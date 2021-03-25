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

    par <- HclustParam(metric = params$metric, method = params$method, cut.dynamic = TRUE)
    
    out <- clusterRows(x = dim, BLUSPARAM = par, full = TRUE)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)