#!/bin/sh

# The process for the UNEAK pipeline would be the following:
#	1) FastqToTagCountPlugin
#	2) MergeMultipleTagCountPlugin (if multiple lanes)
#	3) TagCountToFastqPlugin
#	4) UTagCountToTagPairPlugin
#	5) UExportTagPairPlugin
#	6) FastqToTBTPlugin
#	7) MergeTagsByTaxaFilesPlugin (if multiple lanes)
#	*** hapmap SNP calling ***
#	8) TagsToSNPByAlignmentPlugin (if you want hapmap files no allelic
#	   read depth info)
#	9) MergeDuplicateSNPsPlugin
#	*** VCF SNP calling ***
#	8) tbt2vcfPlugin
#	9) MergeDuplicateSNP_vcf_Plugin

# To call up the arguments that are needed for each plugin you need to do:
# /home/../opt/tassel3.0_standalong/run_pipeline.pl -fork1 -ThePluginName -endPlugin -runfork1

# For processes that require large amounts of memory we can change
# the amount used with the argument -Xmx40g after the run_pipline.pl
# argument.

# The folder structure for the starling GBS pipeline is as follows:
#
# 	starling_gbs/	: This is where all of the data, analysis and
#                         output for this project will be kept. This file,
#                         explaining all of the analysis for this project,
#                         is also contained within this main directory.
#		fastq/		: The raw illumina sequence data is kept
#				  in this folder. There is one file for
#				  each lane/plate of data that we had
#				  sequenced. This folder also has the
# 				  key file, which provides all the extra
#				  data (e.g. sample name, population)
#				  for all of the samples in the fastq
#				  files.
#		FastQCresults/	: This folder contains the output from
#				  running fastqc analysis on the fastq
#				  files fastqc gives quality information
#				  about sequence reads in our fastq files.
#		tagCounts/	: Contains the output files from the first
#				  step of the UNEAK pipeline. One .cnt
#				  (count file) is created for each fastq
#				  file that we have.
#		mergedTagCounts/: Contains the output files from the
#				  second and third step of the UNEAK
#				  pipeline. That is, it creates a
#				  merged Tag Counts file from the individual
#				  files in step 1.
#		topm/		: Contains the file for 'tags on physical
#				  map'. This is a file which identifies
#				  tag pairs for SNP calling and creates
#				  a sudo chromosome
#		tbt/		: This folder contains the file that
#


# ********************************************* #
# START GBS PIPELINE: TASSEL 3.0 UNEAK pipeline #
# ********************************************* #

# 1) Using the plugin FastqToTagCountPlugin, this step finds all barcodes
#    in the key file that match barcoded tags in the fastq raw sequence
#    files. It trims these tags to 64 bases (including the cut sight
#    remnant but after removing the barcode). Reads containing N in
#    the first 64 bases after the barcode are rejected. If a read contains
#    either a full cut sight or the beginning of the comon adapter within
#    the first 64 bases it is truncated appropriately and padded to 64
#    bases with polyA. All the reads are then sorted and indentical
#    reads are collapsed into a single tag. The resulting list of tags
#    is writen into the tagCounts folder and a .cnt file; one file per
#    fastq file.
#	-i	: input directory containing the fastq files, fastq/
#	-k	: key file
#	-e	: Enzyme used to create the GBS library.
#	-c 	: is an argument which specifies the minimum number
#		  of time a tag must be recorded before it is included in
#		  the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#	-s	: simliar to -c only it refers to keeping tags only
#		  under a maximum specified value. Default is 300,000,000
#	-o	: output directory tagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTagCountPlugin -i /home/apcar/starling_gbs/fastq/ -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o /home/apcar/starling_gbs/tagCounts/ -endPlugin -runfork1 &
#		  the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#	-s	: simliar to -c only it refers to keeping tags only
#		  under a maximum specified value. Default is 300,000,000
#	-o	: output directory tagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTagCountPlugin -i /home/apcar/starling_gbs/fastq/ -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o /home/apcar/starling_gbs/tagCounts/ -endPlugin -runfork1 &
#		  the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#	-s	: simliar to -c only it refers to keeping tags only
#		  under a maximum specified value. Default is 300,000,000
#	-o	: output directory tagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTagCountPlugin -i /home/apcar/starling_gbs/fastq/ -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o /home/apcar/starling_gbs/tagCounts/ -endPlugin -runfork1 &
#		  the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#	-s	: simliar to -c only it refers to keeping tags only
#		  under a maximum specified value. Default is 300,000,000
#	-o	: output directory tagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTagCountPlugin -i /home/apcar/starling_gbs/fastq/ -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o /home/apcar/starling_gbs/tagCounts/ -endPlugin -runfork1 &
#    the first 64 bases after the barcode are rejected. If a read contains
#    either a full cut sight or the beginning of the comon adapter within
#    the first 64 bases it is truncated appropriately and padded to 64
#    bases with polyA. All the reads are then sorted and indentical
#    reads are collapsed into a single tag. The resulting list of tags
#    is writen into the tagCounts folder and a .cnt file; one file per
#    fastq file.
#	-i	: input directory containing the fastq files, fastq/
#	-k	: key file
#	-e	: Enzyme used to create the GBS library.
#	-c 	: is an argument which specifies the minimum number
#		  of time a tag must be recorded before it is included in
#		  the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#	-s	: simliar to -c only it refers to keeping tags only
#		  under a maximum specified value. Default is 300,000,000
#	-o	: output directory tagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTagCountPlugin -i /home/apcar/starling_gbs/fastq/ -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o /home/apcar/starling_gbs/tagCounts/ -endPlugin -runfork1 &
#		  the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#	-s	: simliar to -c only it refers to keeping tags only
#		  under a maximum specified value. Default is 300,000,000
#	-o	: output directory tagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTagCountPlugin -i /home/apcar/starling_gbs/fastq/ -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o /home/apcar/starling_gbs/tagCounts/ -endPlugin -runfork1 &


# 2) Using the plugin MergeMultipleTagCountPlugin we merge each of our
#    tagCount files into a simgle 'master' tagCount file.
#    The merged tagCount output file is used as a master tag list for
#    susequent steps in the pipeline.
#       -i      : input directory containing the fastq files, tagCounts/
#       -c      : is an argument which specifies the minimum number of
#		  time a tag must be recorded before it is included in
#                 the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#       -t	: specifies that reads should be output in FASTQ text
#		  format.
#       -o      : output directory mergedTagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -MergeMultipleTagCountPlugin -i tagCounts -o mergedTagCounts/myMasterGBSTags.cnt -c 5 -endPlugin -runfork1 &


# 3) Using the TagCountToFastqPlugin we can convert our master tagCount
#    file containing all the tags of interest for our
#    species into a fastq format for later use.
#       -i      : input directory containing the fastq files,
#		  mergedTagCounts/
#       -c      : is an argument which specifies the minimum number of
#		  time a tag must be recorded before it is included in
#                 the .cnt file. e.g. -c 3, only tags with at least 3
#		  identicle matches will be kept. Default is 1.
#       -o      : output directory mergedTagCounts/

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -TagCountToFastqPlugin -i mergedTagCounts/myMasterGBSTags.cnt -o mergedTagCounts/myMasterGBSTags.fq -endPlugin -runfork1 &


# 4) Using UTagCountToTagPairPlugin we will identify tag pairs for SNP
#    calling via the network filter. Tag pairs with 1 bp mismatch are
#    considered as condidate SNPs. Where a tag is involved in multiple
#    tag pairs, the network filter will indentify reciprocal tag pairs
#    or SNPs. The error tolernace rate (ETR) controls how much mismatching
#    between reciprocal tags will be tolerated, e.g. an ERT of 0 means
#    that only tags that are purely reciprocal will be kept, and that
#    no sequence error happened to these tags. ETR should never be
#    greater than 0.05.
# 	-i	: input directory mergedTagCounts/ .cnt file
#	-e	: Error tolerance rate, between 0 and 0.05.
#	-o 	: output directory topm/ (tags on physical map)

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -UTagCountToTagPairPlugin -i mergedTagCounts/myMasterGBSTags.cnt -o topm/tagPair.tps -e 0.03 -endPlugin -runfork1 &


# 5) We will now export these tag pairs with the UExportTagPairPlugin,
#    and make it into the .topm (Tags on Physical Map) format. This
#    plugin combines the tag pairs into a file that makes them look like
#    a pseudo chormosome.
#	-d 	: distance to pad tag pairs by. Default is 1000
#	-i	: tagPair file from step 4, .tps
#	-m 	: File to export tag pairs to in binary TOPM format
#	-s 	: File to output tag pairs to in SAM format
#	-t 	: File to export tag pairs to in TOPM format

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -UExportTagPairPlugin -i topm/tagPair.tps -m mymasterTags.topm -endPlugin -runfork1 &


# 6) Using FastqToTBTPlugin we will generate a Tags by Taxa file for
#    each FASTQ file in the input directory. Similar to the
#    FastqToTagCountPlugin this step finds all barcodes in the key file
#    that match barcoded tags in the fastq raw sequence files. It trims
#    these tags to 64 bases (including the cut sight remnant but after
#    removing the barcode). Reads containing N in the first 64 bases
#    after the barcode are rejected. If a read contains either a full
#    cut sight or the beginning of the comon adapter within the first
#    64 bases it is truncated appropriately and padded to 64 bases with
#    polyA. This plugin uses barcode information to keep track of which
#    taxa (sample) each tag of interest is observed in. Each good read in
#    each fastq file is checked for a match against our master tag pair,
#    tags on physical map file. One binary ouput file is produced for
#    each of the fastq files that are input. The binary output file
#    format is only readable by the TASSEL pipeline, however, these files
#    can be thought of as a grid where the rows are the tags of interest,
#    the columns headers are taxa names (including
#    "SampleName:Flowcell:Lane:LibraryPrepID), and the cells indicate
#    the number of times a tag was observed in a given taxon. When the
#    -y option is used (recommended), cells have a maximum of 127 reads
#    per tag taxon. The -y option makes it possible to score heterosygotes
#    and homozygotes quantitatively and thus attempt to distinguish type
#    true heterosygotes fom apparent heterozygotes resulting from sequence
#    error. e.g. if one allele at a SNP is observed 20 times and the
#    other allele only once this will be recorded as a homozygote,
#    alternatively, if one allele at a SNP is observed 12 times and the
#    allele 8 times it will be recorded as a heterozygote at that SNP.
#	-i 	: input directory containing fastq files, fastq/
#	-k 	: key file, fastq/
#	-e	: enzyme used
#	-o	: output directory to tag by taxa folder, tbt/
#	-c	: Minimum taxa count within a fastq file for a tag to be
#		  output. Default is 1
#	-t	: master tagCounts .cnt file containing the tags of
#		  interest. File must be binary, .cnt.
#	-m	: TagsOnPhysicalMap .topm file containing tags of
#		  interest. -m and -t are mutually exclusive.
#	-y	: Output in TBTByte format (counts from 0-127) instead
#		  of TBTBit (0 or 1)

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -FastqToTBTPlugin -i /home/apcar/starling_gbs/fastq -k /home/apcar/starling_gbs/fastq/key_file_starling_allplates.txt -e PstI -o tbt -c 3 -y -t /home/apcar/starling_gbs/mergedTagCounts/myMasterGBSTags.cnt -endPlugin -runfork1 &


# 7) Using MergeTagsByTaxaFilesPlugin will merge our tagsByTaxa files
#    that are currently separate for each lane into a
#    single file for all of our lanes and samples.
#	-i	: input directory containing our multiple tagsByTaxa
#		  files.
#	-o	: output file name for our master tags by taxa file.
#	-s	: maximum number of tags the TBT can hold while merging,
#		  to deal with memory problems.
#	-x	: merges tag counts of taxa with identicle sample names,
# 		  ie. sample replicates.

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -MergeTagsByTaxaFilesPlugin -i /home/apcar/starling_gbs/tbt -o mergedTBT/allStarling.tbt.byte -endPlugin -runfork1 &



#-------------------------------------------------------------------------------
# Create the SNP VCF file using TASSEL 3.0
#-------------------------------------------------------------------------------

# 8) Now we will creat a variant call format file from our mergedTBT file
#    with the plugin -tbt2vcfPlugin. The vcf file format provides lots of
#    information about our SNPs. The rows are the different SNPs in our
#    dataset while the colunms include information about each SNP and the
#    representation of that SNP for each individual. The info column will
#    contain, NS = number of samples with data for the SNP, DP = combined
#    depth across samples and AF = allele frequency for each alternative
#    (ALT) allele in the same order as listed.
#	-i       Input .tbt file
#	-o       Output directory (default current directory)
#	-m       TagsOnPhysicalMap file containing genomic position of
# 		 tags
#	-mnMAF   Minimum minor allele frequency (default: 0.0)
#	-mnLCov  Minimum locus coverage (proportion of Taxa with a
#		 genotype) (default: 0.0)
#	-ak      Maximum number of alleles that are kept for each marker
#		 across the population , default: 3
#	-s       Start chromosome
#	-e       End chromosome

# For a full set of snps without filtering those with low coverage.
# We want to create three datasets with different levels of mnMAF.
# mnMAF = 0.1
nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -tbt2vcfPlugin -i /home/apcar/starling_gbs/mergedTBT/allStarling.tbt.byte -o /home/apcar/starling_gbs/vcf/mergedSNPs2/mergedTBT10 -m /home/apcar/starling_gbs/topm/mymasterTags.topm -mnMAF 0.1 -s 1 -e 1 -endPlugin -runfork1 &

# mnMAF = 0.05
nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -tbt2vcfPlugin -i /home/apcar/starling_gbs/mergedTBT/allStarling.tbt.byte -o /home/apcar/starling_gbs/vcf/mergedSNPs2/mergedTBT05 -m /home/apcar/starling_gbs/topm/mymasterTags.topm -mnMAF 0.05 -s 1 -e 1 -endPlugin -runfork1 &

# mnMAF = 0.01
nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -tbt2vcfPlugin -i /home/apcar/starling_gbs/mergedTBT/allStarling.tbt.byte -o /home/apcar/starling_gbs/vcf/mergedSNPs2/mergedTBT01 -m /home/apcar/starling_gbs/topm/mymasterTags.topm -mnMAF 0.01 -s 1 -e 1 -endPlugin -runfork1 &

# 9) Using MergeDuplicateSNP_vcf_Plugin finds duplicate SNPs in the vcf
#    file and merges them if they include the same pair of alleles.
#    Duplicate SNPs may arise where tags overlap but have a different
#    origin cut sight, this usually happens when TagLoci are on different
#    strands, starting on either end of a restriction fragment that is
#    less than 128 bp in length.

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -MergeDuplicateSNP_vcf_Plugin -i /home/apcar/starling_gbs/vcf/mergedSNPs2/mergedTBT10/mergedTBT.c1 -o /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf -endPlugin -runfork1 &

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -MergeDuplicateSNP_vcf_Plugin -i /home/apcar/starling_gbs/vcf/mergedSNPs2/mergedTBT05/mergedTBT.c1 -o /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_05.vcf -endPlugin -runfork1 &

nohup /home/../opt/tassel3.0_standalone/run_pipeline.pl -Xmx40g -fork1 -MergeDuplicateSNP_vcf_Plugin -i /home/apcar/starling_gbs/vcf/mergedSNPs2/mergedTBT01/mergedTBT.c1 -o /home/apcar/starling_gbs/vcf/mergedSNPs2/filter/snps_01.vcf -endPlugin -runfork1 &


# NOTE!!!
# 10) The version of TASSEL that we are using has a bug where our vcf
#     file is created with a header line (ln 6) with '####' (four
#     hashes) where there should only be two '##'. We need to change
#     this before we can convert our files. We can change this
#     anomoly with the following code.

cat ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf | sed 's/####/##/' > ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10hm.vcf
mv ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10hm.vcf ~/starling_gbs/vcf/mergedSNPs2/filter/snps_10.vcf

cat ~/starling_gbs/vcf/mergedSNPs2/filter/snps_05.vcf | sed 's/####/##/' > ~/starling_gbs/vcf/mergedSNPs2/filter/snps_05hm.vcf
mv ~/starling_gbs/vcf/mergedSNPs2/filter/snps_05hm.vcf ~/starling_gbs/vcf/mergedSNPs2/filter/snps_05.vcf

cat ~/starling_gbs/vcf/mergedSNPs2/filter/snps_01.vcf | sed 's/####/##/' > ~/starling_gbs/vcf/mergedSNPs2/filter/snps_01hm.vcf
mv ~/starling_gbs/vcf/mergedSNPs2/filter/snps_01hm.vcf ~/starling_gbs/vcf/mergedSNPs2/filter/snps_01.vcf

# **************** #
# END GBS PIPELINE #
# **************** #
