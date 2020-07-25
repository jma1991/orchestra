#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- mockSCE(ncells = 96, ngenes = 22519, nspikes = 92)

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output)