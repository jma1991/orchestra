#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    sce <- computeSpikeFactors(sce, params$alt)

    fct <- sizeFactors(sce)

    saveRDS(fct, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)