#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    set.seed(1701)

    dec <- modelGeneVarByPoisson(sce)

    saveRDS(dec, output$rds)
}

main(snakemake@input, snakemake@output)