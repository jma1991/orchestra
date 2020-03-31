#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("pheatmap", "RColorBrewer", "SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    hvg <- readRDS(input$rds[2])

    mat <- logcounts(sce)

    mat <- mat[hvg, ]

    mat <- mat - rowMeans(mat)

    pal <- rev(brewer.pal(5, "RdBu"))

    col <- colorRampPalette(pal)(100)

    lim <- max(abs(mat))

    key <- seq(-lim, lim, length.out = 101)

    pheatmap(
        mat, 
        color = col, 
        breaks = key, 
        treeheight_row = 0, 
        treeheight_col = 0, 
        show_rownames = FALSE, 
        show_colnames = FALSE,
        filename = output$pdf
    )

}

main(snakemake@input, snakemake@output)