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
    
    num <- ifelse(ncol(sce) < 100, ncol(sce), 100)

    mem <- quickCluster(sce, min.size = num)
    
    fct <- calculateSumFactors(sce, cluster = mem)

    saveRDS(fct, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)