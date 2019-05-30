#!/bin/sh

# This script will run the fastSTRUCTURE analysis
# for all datasets.

for a in {1..10};
do
  for y in {1..9};
  do
  	for x in 0 3 5;
  	do
  		for i in 01 05 10;
  		do
  	        	echo "#!/bin/sh" > temp.sh
  			      echo working with $y $x $i $a
  	        	echo "mkdir /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y" /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs/global /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs/global/simple
              python /opt/packages/fastStructure/structure.py --input /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y" --output  /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs/global/simple/K -K $a --format=bed --prior simple --full" >> temp.sh
  		        qsub -l qname=Virtual temp.sh
  			      #cat temp.sh
  			      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
  		done
  	done
  done
done
