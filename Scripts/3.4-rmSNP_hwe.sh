#!/bin/sh

# This script will output several files with information on the:
#       - Mean read depth per individual
#       - Depth per site summed across individuals
#       - Mean depth per site averaged across all individuals
#       - Missingness on a per-site basis


for y in {1..9};
do
	for x in 0 3 5;
	do
		for i in 01 05 10;
		do
	        	echo "#!/bin/sh" > temp.sh
			      echo working with $y $x $i
	        	echo "vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/snps_"$i"_"$x"_"$y".recode.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/snps_"$i"_"$x"_"$y"_HWErm --exclude-positions /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/hwe/snps_"$i"_"$x"_"$y"/hwe_rmsnps.txt --recode" >> temp.sh
		        qsub -l qname=Virtual temp.sh
			      #cat temp.sh
			      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
		done
	done
done
