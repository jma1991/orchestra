#!/usr/bin/env Rscript

main <- function(input, output, params, log) {


    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")


    # Script function

    library(SingleCellExperiment)

    sce <- readRDS(input$rds[1])

    res <- readRDS(input$rds[2])

    ix1 <- which(res$Total > params$lower)

    ix2 <- which(res$FDR < params$FDR)

    use <- intersect(ix1, ix2)

    sce <- sce[, use]

    saveRDS(sce, file = output$rds)


}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)