#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(cluster)

    dim <- readRDS(input$rds)

    set.seed(42)
    
    gap <- clusGap(dim, kmeans, K.max = 5)

    saveRDS(gap, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)