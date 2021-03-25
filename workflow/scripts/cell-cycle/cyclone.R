#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    sce <- readRDS(input$rds)
    
    rds <- system.file("exdata", params$pairs, package = "scran")

    ids <- readRDS(rds)

    fit <- cyclone(sce, ids, gene.names = rowData(sce)$ID)

    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)