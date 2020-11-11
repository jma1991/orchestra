#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(bluster)

    dim <- readRDS(input$rds)
    
    out <- clusterRows(dim, NNGraphParam(k = as.numeric(params$k), type = as.character(params$type), cluster.fun = as.character(params$fun)), full = TRUE)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)