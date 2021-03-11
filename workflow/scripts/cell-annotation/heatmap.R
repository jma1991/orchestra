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

pheatmap.labels_row <- function(x) {

    # Return GO Term label

    library(AnnotationDbi)

    library(GO.db)
    
    tools::toTitleCase(mapIds(GO.db, keys = x, keytype = "GOID", column = "TERM"))

}

pheatmap.annotation_col <- function(x) {

    # Return annotation

    data.frame(
        Cluster = x$Cluster,
        row.names = rownames(x)
    )

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

    library(scuttle)

    sce <- readRDS(input$rds[1])

    mat <- readRDS(input$rds[2])

    var <- rowVars(mat)

    ind <- order(var, decreasing = TRUE)

    ind <- head(ind, n = params$n)

    mat <- mat[ind, ]

    std <- pheatmap.mat(mat)

    pheatmap(
        mat = std,
        color = pheatmap.color("RdBu"),
        breaks = pheatmap.breaks(std),
        cluster_rows = pheatmap.cluster_rows(std),
        cluster_cols = pheatmap.cluster_cols(mat),
        annotation_col = pheatmap.annotation_col(colData(sce)),
        show_rownames = TRUE,
        show_colnames = FALSE,
        labels_row = pheatmap.labels_row(rownames(mat)),
        filename = output$pdf,
        width = 15,
        height = 10
    )

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)