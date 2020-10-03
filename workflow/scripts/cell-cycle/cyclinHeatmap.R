#!/usr/bin/env Rscript

coolmap <- function(x) {

    x <- as.matrix(x)

    nsamples <- ncol(x)
    
    hc <- as.dendrogram(hclust(dist(t(x), method = "euclidean"), method = "complete"))

	if(cluster.by=="de pattern") {
		M <- rowMeans(x, na.rm=TRUE)
		DF <- nsamples - 1L
		IsNA <- is.na(x)
		if(any(IsNA)) {
			mode(IsNA) <- "integer"
			DF <-  DF - rowSums(IsNA)
			DF[DF==0L] <- 1L
		}
		x <- x-M
		V <- rowSums(x^2L, na.rm=TRUE) / DF
		x <- x / sqrt(V+0.01)
		sym <- TRUE
		key.xlab <- "Z-Score"
	} else {
		sym <- FALSE
		key.xlab <- "log2(expression)"
	}

#	Dendrogram for rows (genes) uses Euclidean distance
#	If rows are scaled, then this is equivalent to clustering using distance = 1-correlation.
	if(linkage.row=="none") {
		hr <- FALSE
		if(show.dendrogram=="both") show.dendrogram <- "column"
		if(show.dendrogram=="row") show.dendrogram <- "none"
	} else {
		hr <- as.dendrogram(hclust(dist(x, method = "euclidean"), method = "complete"))
	}








main <- function(input, output) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(pheatmap)

    library(scran)

    library(virids)

    sce <- readRDS(input$rds)

    idx <- grep("^Ccn[abde][0-9]$", rowData(sce)$Symbol)

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