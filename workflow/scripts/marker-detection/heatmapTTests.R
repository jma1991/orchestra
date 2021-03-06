#!/usr/bin/env Rscript

sampleByCol <- function(x, f, drop = FALSE, size = 100) {

    # Return object sampled by column

    set.seed(1701)

    by.col <- split(seq_len(ncol(x)), f, drop = drop)

    by.len <- sapply(by.col, length)
    
    by.min <- pmin(by.len, size)

    by.idx <- mapply(sample, x = by.col, size = by.min)

    i <- sort(unlist(by.idx))

    out <- x[, i]

}

orderByCol <- function(x, f) {

    # Return object ordered by column

    by.col <- order(f)

    out <- x[, by.col]

}

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

pheatmap.annotation_col <- function(x) {

    # Return column annotation

    data.frame(Cluster = x$Cluster, row.names = colnames(x))

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(pheatmap)

    library(scuttle)

    sce <- readRDS(input$rds[1])

    sce <- sampleByCol(sce, f = sce$Cluster, size = params$size)

    sce <- orderByCol(sce, f = sce$Cluster)

    res <- readRDS(input$rds[2])

    sig <- lapply(res, subset, FDR < 0.05)

    sig <- lapply(sig, head, n = 5)

    sig <- Filter(nrow, sig)

    if (length(sig) == 0) {

        file.create(output$pdf) # create empty output file
        
        return(invisible()) # return nothing

    }

    ids <- lapply(sig, rownames)

    ids <- unique(unlist(ids))

    lab <- rowData(sce)[ids, "Symbol"]

    mat.x <- assay(sce, "logcounts")[ids, ]

    mat.z <- pheatmap.mat(mat.x)

    pheatmap(
        mat = mat.z,
        color = pheatmap.color("RdBu"),
        breaks = pheatmap.breaks(mat.z),
        cluster_rows = pheatmap.cluster_rows(mat.z),
        cluster_cols = FALSE,
        annotation_col = pheatmap.annotation_col(sce),
        show_rownames = TRUE,
        show_colnames = FALSE,
        labels_row = lab,
        filename = output$pdf,
        width = 12,
        height = 9
    )

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)
