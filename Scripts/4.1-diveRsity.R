# ----------------------------------------------------------------- #
#                      DiveRsity analysis  	                        #
# ----------------------------------------------------------------- #
# To get some basic pop genetic diversity statistics we need to use
# the diveRsity package in R.

library(diveRsity)

# read in out genepop file.
divBasic(infile="data/snps_05_3_5/snps_05_3_5_genepop.txt",
         outfile="output/diveRsity/snps_05_3_5_divBasic",
         bootstraps = 1000, gp = 3)
