#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    fct <- readRDS(input$rds[2])

    sizeFactors(sce) <- fct

    sce <- logNormCounts(sce)

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)