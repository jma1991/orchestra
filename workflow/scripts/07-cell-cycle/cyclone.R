#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    rds <- system.file("exdata", "mouse_cycle_markers.rds", package = "scran")

    mcm <- readRDS(rds)

    set.seed(1701)

    fit <- cyclone(sce, mcm, gene.names = rowData(sce)$gene_id)

    sce$phase <- factor(fit$phases, levels = c("G1", "S", "G2M"))

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)