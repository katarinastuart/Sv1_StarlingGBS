#!/bin/sh

# This script will produce three vcf files for each level of minMAF, 0.01, 0.05
# & 0.10. These three files correspond to levels of filtering on minDP, 0, 3 &
# 5. This will result in 9 different vcf files that will be named as follows,
# 'snps_minMAF_minDP.recode.vcf', e.g. snps_01_3.recode.vcf.
# Setting the maximum coverage to 10X the mean coverage is based on
# https://www.biostars.org/p/16292/


x=1
for x in 0 3 5;
do
	for i in 01 05 10;
	do
        	echo "#!/bin/sh" > temp.sh
		      echo working with $x $i
        	echo "vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_"$i"_1.recode.vcf --out /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_"$i"_"$x" --minDP $x --maxDP 60 --recode" >> temp.sh
	        qsub -l qname=Virtual temp.sh
		      #cat temp.sh
		      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
	done
done
