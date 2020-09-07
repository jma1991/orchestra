#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("scran", "pheatmap")

    lib <- lapply(pkg, library, character.only = TRUE)

    snn <- readRDS(input$rds[1])

    fct <- readRDS(input$rds[2])

    mod <- clusterModularity(snn, fct, as.ratio = TRUE)

    pal <- c("#f7f7f7", "#252525")

    col <- colorRampPalette(pal)(100)

    pheatmap(
        mat = log2(mod + 1),
        color = col,
        cluster_rows = FALSE,
        cluster_cols = FALSE,
        filename = output$pdf
    )

}

main(snakemake@input, snakemake@output, snakemake@wildcards)
