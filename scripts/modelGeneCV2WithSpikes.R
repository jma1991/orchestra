#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dec <- modelGeneCV2WithSpikes(sce, params$alt)

    saveRDS(dec, output$rds)
}

main(snakemake@input, snakemake@output, snakemake@params)