#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    dim <- readRDS(input$rds)
    
    snn <- buildSNNGraph(dim, k = as.numeric(params$k), type = as.character(params$type), transposed = TRUE)

    saveRDS(snn, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)