#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    sce <- readRDS(input$rds[1])

    dec <- readRDS(input$rds[2])

    hvg <- rowSubset(sce, "HVG")

    sce <- denoisePCA(sce, technical = dec, subset.row = hvg)

    dim <- reducedDim(sce, "PCA")

    num <- ncol(dim)

    saveRDS(num, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)