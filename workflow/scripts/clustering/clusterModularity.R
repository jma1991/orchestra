#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    knn <- readRDS(input$rds[1])

    mem <- readRDS(input$rds[2])

    out <- clusterModularity(knn, mem, as.ratio = TRUE)

    saveRDS(out, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)