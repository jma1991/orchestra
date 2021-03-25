#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(cluster)

    dim <- readRDS(input$rds)

    set.seed(1701)

    out <- clusGap(dim, kmeans, K.max = 50)
    
    out$maxSE <- maxSE(out$Tab[, "gap"], out$Tab[, "SE.sim"])

    saveRDS(out, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)