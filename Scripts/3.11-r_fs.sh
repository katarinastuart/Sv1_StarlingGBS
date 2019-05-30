#!/bin/sh

# This script will produce a file for
# K values from 1 to 10. Each file will
# have 100 iterations of the logistic
# fastSTRUCTURE run. The files will then
# be run to produce 100 repeated runs of
# each K. This uses the runRepsStructure.pl
# file to produce the new files. To run this
# across all computers in the cluster with the
# qsub function the script needs to be submitted
# on to the SUN GRID CLUSTER in
# mamsap.it.deakin.edu. SO go to this computer
# using 'ssh mamsap', and then submit the job
# with 'nohup r_fs_10.sh'.

y=1
while [ $y -lt 101 ]
do
	for x in {2..4};
	do
		for i in neutral outlier whole;
		do
						echo "#!/bin/sh" > temp.sh
						echo working with $i $x $y
						echo "
						python /opt/packages/fastStructure/structure.py --input /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_05_3_5/$i/snps_05_3_5_$i --output  /home/apcar/starling_gbs/vcf/mergedSNPs2/output/fs/$i/global/repeat/K"$y" -K $x --format=bed --prior logistic --full" >> temp.sh
						qsub -l qname=Virtual temp.sh
						#cat temp.sh
						rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
		done
	done
	y=$(( $y + 1 ))
done


# Now that we have our 100 runs for K's of 1-10
# we will extract the Maximum Likelihood values
# from each .log file with the following code.

# grep "Marginal Likelihood = " repeated/*.log | perl -pe 's/:Marginal Likelihood = /\t/' > repeated/likes
