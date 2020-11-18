#!/usr/bin/env Rscript

set.seed(1701)

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    sce <- readRDS(input$rds)

    mem <- quickCluster(sce)
    
    out <- calculateSumFactors(sce, cluster = mem)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)