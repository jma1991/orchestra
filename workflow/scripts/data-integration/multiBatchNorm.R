#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("batchelor")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- lapply(input$rds, readRDS)

    ##

    ids <- Reduce(intersect, lapply(sce, rownames))
    
    sce <- lapply(sce, "[", i = ids, )
    
    ##
    
    sce <- do.call(multiBatchNorm, sce)

}

main(snakemake@input, snakemake@output)