#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(cluster)

    gap <- readRDS(input$rds)
    
    max <- maxSE(gap$Tab[, "gap"], gap$Tab[, "SE.sim"])

    saveRDS(max, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)