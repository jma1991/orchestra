#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dim <- calculatePCA(sce)

    saveRDS(dim, output$rds)

}

main(snakemake@input, snakemake@output)