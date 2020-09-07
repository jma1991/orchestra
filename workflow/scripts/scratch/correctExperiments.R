#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("batchelor")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- lapply(input$rds, readRDS)

    hvg <- readRDS(input$rds)
    
    set.seed(1701)

    par <- FastMnnParam(merge.order = params$idx)

    mnn <- correctExperiments(sce, batch = sce.chimera$sample, subset.row = hvg, PARAM = par)

    saveRDS(mnn, output$rds)

}

main(snakemake@input, snakemake@output)