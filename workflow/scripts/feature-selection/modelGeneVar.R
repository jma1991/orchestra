#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dec <- modelGeneVar(sce)

    saveRDS(dec, output$rds)
}

main(snakemake@input, snakemake@output)