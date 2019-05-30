 #!/bin/sh

# This script will output sample depth information for each of our 9 files, we
# will use this information to identify sampes with less that 10% of the total
# number of SNPs and remove them.


x=1
for x in 0 3 5;
do
	for i in 01 05 10;
	do
        	echo "#!/bin/sh" > temp.sh
		      echo working with $x $i
        	echo "vcftools --vcf /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_"$i"_"$x"_1.recode.vcf --depth -c > /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/minDP/snps_"$i"_"$x"_1indv.txt" >> temp.sh
	        qsub -l qname=Virtual temp.sh
		      #cat temp.sh
		      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
	done
done
