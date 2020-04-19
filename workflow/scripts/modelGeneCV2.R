#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dec <- modelGeneCV2(sce)

    saveRDS(dec, output$rds)
}

main(snakemake@input, snakemake@output)