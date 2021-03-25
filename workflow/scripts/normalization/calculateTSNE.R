#!/usr/bin/env Rscript

main <- function(input, output, log, threads) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scater)

    mat <- readRDS(input$rds)

    num <- 2

    set.seed(1701)

    dim <- calculateTSNE(mat, ncomponents = num, transposed = TRUE)

    rownames(dim) <- rownames(mat)

    colnames(dim) <- paste0("TSNE.", seq_len(num))

    saveRDS(dim, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@threads)