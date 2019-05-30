#!/bin/sh

# This script will run the fastSTRUCTURE analysis
# for all datasets.
# When printing the number of individuals and number of snps we use
# 'wc -l' to count the number of rows and then use awk to minus 1 from
# this number because of the header row.


  for y in {1..9};
  do
  	for x in 0 3 5;
  	do
  		for i in 01 05 10;
  		do
  			      echo working with $y $x $i
  	        	echo minMAF = $i >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              echo minDP = $x >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              echo sCov = $y >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              python /opt/packages/fastStructure/chooseK.py --input=/home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs/global/simple/K* >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              wc -l /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_siteDP.txt | awk '{print "nSNPs = " $1-1}' >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              wc -l /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_indvDP.txt | awk '{print "nSamps = " $1-1}' >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              cat /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_indvDP.txt | awk 'NR>1{sum+=$3}END{print "samples average mean depth = ",sum/(NR-1)}' >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              cat /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_siteMiss.txt | awk 'NR>1{sum+=$6}END{print "sites average frequency of missingness = ",sum/(NR-1)}' >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              cat /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_siteDP.txt | awk 'NR>1{sum+=$3}END{print "sites average total number of reads = ",sum/(NR-1)}' >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

              cat /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y"_sitemnDP.txt | awk 'NR>1{sum+=$3}END{print "sites average mean depth = ",sum/(NR-1)}' >> /home/apcar/starling_gbs/vcf/mergedSNPs2/output/K_all_datasets.txt

  		done
  	done
  done
