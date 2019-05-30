#!/bin/sh

# This script will run the fastSTRUCTURE analysis
# for outlier subpop datasets.



  	for x in {1..10};
  	do
  		for i in p1 p2;
  		do
  	        	echo "#!/bin/sh" > temp.sh
  			      echo working with $x $i
  	        	echo "
              python /opt/packages/fastStructure/structure.py --input /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_05_3_5/outlier/$i/snps_05_3_5_outlier-$i --output  /home/apcar/starling_gbs/vcf/mergedSNPs2/output/fs/outlier/subK2/$i/simple/K -K $x --format=bed --prior simple --full" >> temp.sh
  		        qsub -l qname=Virtual temp.sh
  			      #cat temp.sh
  			      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
  		done
  	done
