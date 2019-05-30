# This code will be used to run bayescan on the landgen data set.
library(PopGenome)

# To import the data we use the 'readVCF()' function, 'topos'
# specifies the lenght of chromosome '1'. We want to read in our 
# filtered dataset.
datGP <- readVCF("/home/apcar/starling_gbs/vcf/landgen/data/data_formats/landgen_data.recode.vcf.gz", tid = '1', frompos = 1, topos = 300000000, numcols = 1000, include.unknown = TRUE)

# Now we want to specify the populations for our data, so first we
# will create population vectors which identify which samples are
# in each population. We will do this with a file called populations
# to save us copy pasting everything. These populations were 
# determined from fastSTRUCTURE analysis.
source('/home/apcar/starling_gbs/vcf/landgen/src/populations.R')

# Now we can specify these populations within our dataset.
datGP <- set.populations(datGP, list(p1.1, p1.2, p2, p3))

# Now we can start filling in our datasets with some stats. We
# are working with an S4 class object with slots, in PopGenome
# when you run one of the statistical analysis functions, e.g.
# F_ST.stats(), the output fills related slots. For example,
# running F_ST.stats() fills many different slots depending on
# the parameters that are selected. To check out all the
# different slots, use show.slots().
# Lets start by calculating FST stats. The 'detail = TRUE'
# parameter is telling the funciton to calculate all of the
# associated F_ST statistics rather than just a select few.
# NOTE: because of the type of data we have we will only get
# nucleotide statistics back.
# NOTE2: the function F_ST.stats.2() takes a considerably longer
# amount of time to run compared to F_ST.stats.
datGP <- F_ST.stats(datGP, detail = TRUE)

# We will now test to see whether the function BayeScanR in the
# PopGenome package is able to identify outlier loci in our data
# set.
bayesInput <- getBayes(datGP, snps = TRUE)


bayesClass <- BayeScanR(bayesInput, nb.pilot = 20, pilot.runtime = 5000, main.runtime = 100000, discard = 50000)

dat <- data.frame('alpha' = bayesClass@alpha, 'var_alpha' = bayesClass@var_alpha,'a_inc' = bayesClass@a_inc, 'fst' = bayesClass@fst,	'p' = bayesClass@P)
									
write.table(dat, '/home/apcar/starling_gbs/vcf/landgen/output/bayescan/bayescan_results.txt', sep = ',', col.names = TRUE, row.names = FALSE)


