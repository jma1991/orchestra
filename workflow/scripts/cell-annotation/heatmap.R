#!/usr/bin/env Rscript

pheatmap.mat <- function(x) {

    # Scale rows by 'variance-aware' Z-transformation

    M <- rowMeans(x, na.rm = TRUE)

    DF <- ncol(x) - 1

    isNA <- is.na(x)

    if ( any(isNA) ) {

        mode(isNA) <- "integer"

        DF <-  DF - rowSums(isNA)

        DF[DF == 0] <- 1

    }

    x <- x - M

    V <- rowSums(x^2, na.rm = TRUE) / DF

    x <- x / sqrt(V + 0.01)

}

pheatmap.color <- function(x) {

    # Return color vector

    colorRampPalette(rev(RColorBrewer::brewer.pal(n = 5, name = x)))(100)

}

pheatmap.breaks <- function(x) {

    # Return breaks vector

    abs <- max(abs(x))

    abs <- min(abs, 5)

    seq(-abs, +abs, length.out = 101)

}

pheatmap.cluster_rows <- function(x) {

    # Return hclust object for rows

    hclust(dist(x, method = "euclidean"), method = "complete")

}

pheatmap.cluster_cols <- function(x) {

    # Return hclust object for columns

    hclust(dist(t(x), method = "euclidean"), method = "complete")

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(matrixStats)

    library(pheatmap)

    mat.x <- readRDS(input$rds)

    var <- rowVars(mat.x)

    ind <- order(var, decreasing = TRUE)

    ind <- head(ind, n = params$n)

    mat.x <- mat.x[ind, ]

    mat.z <- pheatmap.mat(mat.x)

    pheatmap(
        mat = mat.z,
        color = pheatmap.color("RdBu"),
        breaks = pheatmap.breaks(mat.z),
        cluster_rows = pheatmap.cluster_rows(mat.z),
        cluster_cols = pheatmap.cluster_cols(mat.x),
        show_rownames = TRUE,
        show_colnames = FALSE,
        filename = output$pdf,
        width = 8,
        height = 6
    )

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)