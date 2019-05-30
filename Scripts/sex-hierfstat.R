library(hierfstat)

    fd <- read.fstat("data/snps_05_3_5/snps_05_3_5_FSTAT_female.dat")
    md <- read.fstat("data/snps_05_3_5/snps_05_3_5_FSTAT_male.dat")

    fbso <- basic.stats(fd, digits=4)
    fbso$overall
    fpairNei <- genet.dist(fd, method = "Nei87")
    fpairNei
    fpfst <- boot.ppfst(dat=fd,nboot=10000,quant=c(0.025,0.975),diploid=TRUE,dig=4)
    write.table(fbso$overall, "output/hierfstat/female_dataset_overall-basicStats.txt", sep = '\t', col.names = TRUE, row.names = FALSE)
    write.table(fpfst$ul, file = "output/hierfstat/female_dataset_overall-basicStats.txt", sep = ',',
            col.names = FALSE, append = TRUE)
    write.table(fpfst$ll, file = "output/hierfstat/female_dataset_overall-basicStats.txt", sep = ',',
            col.names = FALSE, append = TRUE)

    mbso <- basic.stats(md, digits=4)
    mbso$overall
    mpairNei <- genet.dist(md, method = "Nei87")
    mpairNei
    mpfst <- boot.ppfst(dat=md,nboot=10000,quant=c(0.025,0.975),diploid=TRUE,dig=4)
    write.table(mbso$overall, "output/hierfstat/male_dataset_overall-basicStats.txt", sep = '\t', col.names = TRUE, row.names = FALSE)
    write.table(mpfst$ul, file = "output/hierfstat/male_dataset_overall-basicStats.txt", sep = ',',
            col.names = FALSE, append = TRUE)
    write.table(mpfst$ll, file = "output/hierfstat/male_dataset_overall-basicStats.txt", sep = ',',
            col.names = FALSE, append = TRUE)


