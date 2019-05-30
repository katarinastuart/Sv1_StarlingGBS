#!/bin/sh

# The following code will filter out our blanks and remove undesirable
# individuals. Undersirable individuals include those samples
# that have less than 10% of the total number of SNPs from the whole
# data set and accidently repeated samples. The script takes the
# following steps to achieve this:
#       1. Remove blank samples and repeated samples using vcftools.
#	      2. Remove genotypes that don't have a minimum depth of 3.
#       2. Determine how many SNPs each sample has using the vcftools
#          function '--depth'. This function produces a file with three
#          columns, $1 sample name, $2 number of SNPs, $3 mean depth of
#          SNPs for that individual.
#       3. Calculate the average number SNPs, and determine what 10% of
#          this number is.
#       4. Produce a new text file with samples names of individuals
#          that have less than the 10% of the average number of SNPs.
#       5. Remove the poorly represented individuals from the vcf
#          file using vcftools.
#       6. Produce a new vcf file that only includes SNPs with a coverage
#          that we specify. This is done using vcftools function
#          '--max-missing' and will produce a new file where any SNPs
#          that are not present in at least X% of the samples are
#	   excluded.

# Before proceeding we want to filter out all the blank samples.
# In the original dataset there were also a couple of indivdiuals who
# were accidently sequenced twice. To do this we will create an
# output file of the missingness for each individual.
vcftools --vcf ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf --missing-indv -c > ~/starling_gbs/vcf/mergedSNPs2/filter/missing-ind10.txt

vcftools --vcf ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf --missing-indv -c > ~/starling_gbs/vcf/mergedSNPs2/filter/missing-ind05.txt

vcftools --vcf ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf --missing-indv -c > ~/starling_gbs/vcf/mergedSNPs2/filter/missing-ind01.txt

# Now we will look through this file for repeated individuals. We
# found two individuals that were sequenced twice, we will remove
# the repeated sample with the least number of loci.
#SV073:C3J4CACXX:1:250269849    123566  0       100937  0.816867
#SV073:C4AP5ACXX:6:250293529    123566  0       100062  0.809786

#SV411:C3J4CACXX:1:250269854    123566  0       113098  0.915284
#SV411:C4AP5ACXX:6:250293533    123566  0       122319  0.989908

#We can remove these individuals using vcfTools as follows:
vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_10_1 --remove-indv blank:C4AP5ACXX:6:250293471 --remove-indv Blank:C4AP5ACXX:2:250293891 --remove-indv Blank:C4AP5ACXX:3:250293717 --remove-indv Blank:C4AP5ACXX:5:250293661 --remove-indv Blank:C3J4CACXX:1:250269933 --remove-indv Blank:C4AP5ACXX:1:250293968 --remove-indv SV073:C3J4CACXX:1:250269849 --remove-indv SV411:C4AP5ACXX:6:250293533 --recode

vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_05.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_05_1 --remove-indv blank:C4AP5ACXX:6:250293471 --remove-indv Blank:C4AP5ACXX:2:250293891 --remove-indv Blank:C4AP5ACXX:3:250293717 --remove-indv Blank:C4AP5ACXX:5:250293661 --remove-indv Blank:C3J4CACXX:1:250269933 --remove-indv Blank:C4AP5ACXX:1:250293968 --remove-indv SV073:C3J4CACXX:1:250269849 --remove-indv SV411:C4AP5ACXX:6:250293533 --recode

vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_01.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_01_1 --remove-indv blank:C4AP5ACXX:6:250293471 --remove-indv Blank:C4AP5ACXX:2:250293891 --remove-indv Blank:C4AP5ACXX:3:250293717 --remove-indv Blank:C4AP5ACXX:5:250293661 --remove-indv Blank:C3J4CACXX:1:250269933 --remove-indv Blank:C4AP5ACXX:1:250293968 --remove-indv SV073:C3J4CACXX:1:250269849 --remove-indv SV411:C4AP5ACXX:6:250293533 --recode

# There is also a typo in one of the ID names that we will change.
# Dubb015:C3J4CACXX:1:250269882, should not have a 0 after Dubb.
sed -r 's/Dubb015:C3J4CACXX:1:250269882/Dubbo15:C3J4CACXX:1:250269882/' /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_10_1.recode.vcf > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/temp_del
mv /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/temp_del /home/apcar/starling_gbs/vcf/mergedSNPs2/filter//snps_10_1.recode.vcf

sed -r 's/Dubb015:C3J4CACXX:1:250269882/Dubbo15:C3J4CACXX:1:250269882/' /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_05_1.recode.vcf > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/temp_del
mv /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/temp_del /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_05_1.recode.vcf

sed -r 's/Dubb015:C3J4CACXX:1:250269882/Dubbo15:C3J4CACXX:1:250269882/' /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_01_1.recode.vcf > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/temp_del
mv /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/temp_del /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_01_1.recode.vcf

# To make sure all of our changes have been made we can look at
# the first column using the following awk command and check our
# names.
vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_10_1.recode.vcf --missing-indv -c | awk -F ' ' '{print $1}'

# Now we want to filter out any sample/locus combination (i.e. genotype)
# that has less than X number of reads. This will include 3 and 5, and we will
# keep an original file with no filtering by genotype. A src file does this
# for us iteritively.
/home/apcar/starling_gbs/vcf/filter_snps2/src/2.1-minDP.sh

# Because we will have removed many genotypes in the last step we will
# now filter out any SNPs that don't have a sample depth of at least 10%.
/home/apcar/starling_gbs/vcf/filter_snps2/src/2.2-snps_max-missing.sh

# Now we want to filter out all individuals that have less than 10% of
# the total number of sites. First we have to get the stats for each
# and determine the total number of SNPs per dataset. To get our stats for
# samples and sites we use some scripts we have written. We can get the total
# number of SNPs by counting the number of rows in out site_depth output file.
/home/apcar/starling_gbs/vcf/filter_snps2/src/2.3-indv-missing.sh
/home/apcar/starling_gbs/vcf/filter_snps2/src/2.4-site_depth.sh

awk -F, 'END{print NR}' filter/minDP/snps_01_0_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_01_3_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_01_5_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_05_0_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_05_3_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_05_5_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_10_0_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_10_3_1site.txt
awk -F, 'END{print NR}' filter/minDP/snps_10_5_1site.txt

# This resulted in;
#       minMAF - .01 & minDP - 0 = 134338
#       minMAF - .01 & minDP - 3 = 118946
#       minMAF - .01 & minDP - 5 = 105043
#       minMAF - .05 & minDP - 0 = 78434
#       minMAF - .05 & minDP - 3 = 69572
#       minMAF - .05 & minDP - 5 = 61936
#       minMAF - .10 & minDP - 0 = 51526
#       minMAF - .10 & minDP - 3 = 45616
#       minMAF - .10 & minDP - 5 = 40559

# Now we can identify those samples that have less than 10% of the total number
# of snps.
cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_01_0_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_01_0_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_01_3_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_01_3_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_01_5_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_01_5_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_05_0_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_05_0_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_05_3_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_05_3_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_05_5_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_05_5_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_10_0_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_10_0_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_10_3_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_10_3_1rmID.txt

cat /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_10_5_1indv.txt | awk '{ if ($2 <= 13433) print $1}' > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_10_5_1rmID.txt


# Now we will use these text file to remove those poorly represented
# individualswith vcftools.
/home/apcar/starling_gbs/vcf/filter_snps2/src/2.5-rm_indv.sh


# This script will now filter out any SNPs that don't have a sample depth of
# at least 10%.
/home/apcar/starling_gbs/vcf/filter_snps2/src/2.6-max-missing_lvls.sh
