#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(velociraptor)

    sce <- scvelo(sce, subset.row = hvg, use.dimred = "PCA")

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)