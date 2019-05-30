#!/bin/sh

# This script will run the fastSTRUCTURE analysis
# for all datasets.

r=1
while [ $r -lt 101 ]
do
  for a in {2..4};
    do
    for y in 5 6;
      do
      	for x in 0 3;
      	do
      		for i in 05;
      		do
      	        	echo "#!/bin/sh" > temp.sh
      			      echo working with $y $x $i $a
      	        	echo "mkdir /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs/global/repeat
                  python /opt/packages/fastStructure/structure.py --input /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y" --output  /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/output/fs/global/repeat/K_$r -K $a --format=bed --prior logistic --full" >> temp.sh
      		        qsub -l qname=Virtual temp.sh
      			      #cat temp.sh
      			      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
      		done
      	done
      done
  done
r=$(( $r + 1 ))
done
