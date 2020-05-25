#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    set.seed(1701)

    com <- quickCluster(sce)

    fct <- calculateSumFactors(sce, cluster = com)

    saveRDS(fct, output$rds)

}

main(snakemake@input, snakemake@output)