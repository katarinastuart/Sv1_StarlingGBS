#!/bin/sh

#---------------------------------------------------------------------
# This code will use each population file that was created in
# starling/pops/sep_pop/ to filter our vcf file and output statistics
# on HWE. We will get one file for each of our populations that gives
# the HWE for each loci.

FILES=/home/apcar/starling_gbs/pops/vcf_form/vcf_form_*

for g in $FILES
do
	for y in {1..9};
	do
		for x in 0 3 5;
		do
			for i in 01 05 10;
			do
				      echo working with $y $x $i
							newfile="$(basename $g )"
							echo ${newfile}
		        	echo "mkdir /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/hwe/snps_"$i"_"$x"_"$y"
							vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/snps_"$i"_"$x"_"$y".recode.vcf --keep /home/apcar/starling_gbs/pops/vcf_form/"${newfile}" --hardy -c > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/hwe/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_"${newfile}"_hwe.txt
	            " >> temp.sh
			        qsub -l qname=Virtual temp.sh
				      #cat temp.sh
				      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
			done
		done
	done
done
#--------------------------------------------------------------------

# FILES=/home/apcar/starling_gbs/pops/vcf_form/vcf_form_*
#
# for i in $FILES
# do
# 	echo working with $i
# 	newfile="$(basename $i )"
# 	echo ${newfile}
# 	vcftools --vcf /home/apcar/starling_gbs/vcf/snps_10_40/data_formats/p1/fullFilt_40_p1.recode.vcf --keep /home/apcar/starling_gbs/pops/vcf_form/"${newfile}" --hardy -c > /home/apcar/starling_gbs/vcf/snps_10_40/hwe/p1/snps_40_p1_hwe_"${newfile}"
#
# done
