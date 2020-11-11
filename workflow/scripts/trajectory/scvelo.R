#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(BiocParallel)

    library(scuttle)

    library(velociraptor)

    sce <- readRDS(input$rds)

    hvg <- rowSubset(sce, "HVG")

    fct <- list(
        counts = librarySizeFactors(sce, assay.type = "counts"),
        spliced = librarySizeFactors(sce, assay.type = "spliced"),
        unspliced = librarySizeFactors(sce, assay.type = "unspliced")
    )

    lgl <- lapply(fct, ">", 0)

    use <- Reduce("&", lgl)

    sce <- sce[, use]

    sce <- scvelo(x = sce, subset.row = hvg, use.dimred = "PCA")

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)