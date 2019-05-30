#!/bin/sh

# This script will now filter out SNPs at different levels from 10% to 90%.


for y in {1..9};
do
	for x in 0 3 5;
	do
		for i in 01 05 10;
		do
	        	echo "#!/bin/sh" > temp.sh
			      echo working with $y $x $i
	        	echo "vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_"$i"_"$x"_2.recode.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/lvls/snps_"$i"_"$x"_"$y" --max-missing 0.$y --recode" >> temp.sh
		        qsub -l qname=Virtual temp.sh
			      #cat temp.sh
			      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
		done
	done
done
