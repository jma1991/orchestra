#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("pheatmap", "scran", "viridis")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    idx <- grep("^Ccn[abde][0-9]$", rowData(sce)$gene_name)

    mat <- logcounts(sce)[idx, , drop = FALSE]
    
    pheatmap(
        mat = mat,
        color = viridis(100),
        breaks = seq(0, max(mat), length.out = 101),
        show_colnames = FALSE
        filename = output$pdf
    )

}

main(snakemake@input, snakemake@output, snakemake@params)