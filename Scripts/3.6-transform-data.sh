#!/bin/sh

# In order to run the genetic analysis in the various genetic
# software that we require we need to transform the data into the
# formats that each program recognises. The formats that we need
# are:
#   - PCAdapt
#	- PopGenome gsipped tabixed vcf files
#   - fastStructure plink .bed format
#   - BOLT-LMM uses plink bed/bim/fam file triple
#   - Adegenet uses plink .raw file

# PCAdapt is a program that is used to identify outlier loci in large
# SNP datasets. It includes functions to convert .vcf formated files
# to the file format required.

# PopGenome is a package in R that takes a variety of vcf files and
# allows you to run standard population genetic analysis on large
# genomic datasets. PopGenome takes gzipped tabixed vcf files so we
# will gzip and tabix our file to make it usable. bgsip and tabix
# only work on gandalf, so move into one of those computers before
# doing the next couple of steps.
# First we will make a copy of our .vcf fill in the 'data_formats'
# folder and then compress it with bgzip.

# Now that it has been bgzipped we can tabix the file, which produces
# a tabbed index file that goes with the bgzipped file.

# fastSTRUCTURE is a linux based program that can be used to identify
# population structure. To use fastSTRUCTURE we need to convert our
# vcf file into a format that can be read by the program, that is a
# plink .bed format. To get our vcf file into this format we first
# need to convert it into a plink .ped format and then to .bed.

# This searches through all files similar to the --file and looks for a
# file ending in .ped. The .ped file is created from the previous command.

# This creates a .raw file that can then be imported into R via adegenet.


for y in {1..9};
do
	for x in 0 3 5;
	do
		for i in 01 05 10;
		do
	        	echo "#!/bin/sh" > temp.sh
			      echo working with $y $x $i
	        	echo "plink --file /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y" --out /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y" --make-bed

            plink --file /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y" --out /home/apcar/starling_gbs/vcf/mergedSNPs2/data/snps_"$i"_"$x"_"$y"/snps_"$i"_"$x"_"$y" --recodeA" >> temp.sh
		        #qsub -l qname=Virtual temp.sh
			      cat temp.sh
			      rm /home/apcar/starling_gbs/vcf/mergedSNPs2/temp.sh
		done
	done
done
