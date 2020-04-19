#!/usr/bin/env Rscript

main <- function(input, output, params, threads) {

    pkg <- c("SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    dim <- readRDS(input$rds[2])

    per <- vapply(out, "[[", "perplexity", FUN.VALUE = numeric(1))
    
    itr <- vapply(out, "[[", "max_iter", FUN.VALUE = numeric(1))

    idx <- which(params$per == per & params$itr == itr)

    reducedDim(sce, "TSNE") <- dim[[idx]]

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@threads)