#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    sce <- readRDS(input$rds)

    mem <- quickCluster(sce, min.size = 100)
    
    out <- calculateSumFactors(sce, cluster = mem)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)