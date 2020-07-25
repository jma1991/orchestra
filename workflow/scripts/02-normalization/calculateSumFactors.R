#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scran)

    sce <- readRDS(input$rds)
    
    set.seed(1701)
    
    num <- ifelse(ncol(sce) < 100, ncol(sce), 100)
    
    mem <- quickCluster(sce, min.size = num)
    
    fct <- calculateSumFactors(sce, cluster = mem)

    dat <- data.frame(cellName = colnames(sce), sizeFactor = fct)

    write.csv(dat, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output)