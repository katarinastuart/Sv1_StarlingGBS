#!/bin/sh

# This script will now filter out any SNPs that don't have a sample depth of
# at least 10%.


x=1
for x in 0 3 5;
do
	for i in 01 05 10;
	do
        	echo "#!/bin/sh" > temp.sh
		      echo working with $x $i
        	echo "vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_"$i"_"$x".recode.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_"$i"_"$x"_1 --max-missing 0.1 --recode" >> temp.sh
	        qsub -l qname=Virtual temp.sh
		      #cat temp.sh
		      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
	done
done
