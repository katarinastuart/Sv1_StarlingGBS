library(hierfstat)

fd <- read.fstat("data/snps_05_3_5/snps_05_3_5_FSTAT.dat")
lvl <- read.table("output/hierfstat/snps053_hierfstat_levels.txt")

pfst <- boot.ppfst(dat=fd,nboot=10000,quant=c(0.025,0.975),diploid=TRUE,dig=4)

write.table(pfst$ll, "output/hierfstat/snps_05_3_5_16K_bootstarppedPairwiseFst_lowerLimit.txt", sep = '\t', col.names = TRUE, row.names = FALSE)
write.table(pfst$ul, "output/hierfstat/snps_05_3_5_16K_bootstarppedPairwiseFst_upperLimit.txt", sep = '\t', col.names = TRUE, row.names = FALSE)

