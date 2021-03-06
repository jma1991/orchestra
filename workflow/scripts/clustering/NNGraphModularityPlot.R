#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(pheatmap)

    mat <- readRDS(input$rds)

    pheatmap(
        mat = log10(mat + 1),
        color = rev(heat.colors(100)),
        cluster_rows = FALSE,
        cluster_cols = FALSE,
        angle_col = 0,
        filename = output$pdf,
        width = 8,
        height = 6
    )

}

main(snakemake@input, snakemake@output, snakemake@log)