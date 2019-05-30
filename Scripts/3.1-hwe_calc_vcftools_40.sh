#!/bin/sh

#---------------------------------------------------------------------
# This code will use each population file that was created in
# starling/pops/sep_pop/ to filter our vcf file and output statistics
# on HWE. We will get one file for each of our populations that gives
# the HWE for each loci.
FILES=/home/apcar/starling_gbs/pops/vcf_form/vcf_form_*

for i in $FILES
do
	echo working with $i
	newfile="$(basename $i )"
	echo ${newfile}
	vcftools --vcf /home/apcar/starling_gbs/vcf/snps_10_40/data_formats/p1/fullFilt_40_p1.recode.vcf --keep /home/apcar/starling_gbs/pops/vcf_form/"${newfile}" --hardy -c > /home/apcar/starling_gbs/vcf/snps_10_40/hwe/p1/snps_40_p1_hwe_"${newfile}"

done

#--------------------------------------------------------------------
