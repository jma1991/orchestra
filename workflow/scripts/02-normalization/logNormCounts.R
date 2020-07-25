#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    dat <- read.csv(input$csv)

    sizeFactors(sce) <- dat$sizeFactor

    sce <- logNormCounts(sce)

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)