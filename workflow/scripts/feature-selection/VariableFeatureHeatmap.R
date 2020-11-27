#!/usr/bin/env Rscript

rescale <- function(x) {

    # Scale rows by Z-transformation
    
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

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    library(pheatmap)

    sce <- readRDS(input$rds[1])

    hvg <- readRDS(input$rds[2])

    sel <- sample(seq_len(ncol(sce)), 100)

    x <- logcounts(sce)[hvg, sel]

    z <- rescale(x)

    pheatmap(
        mat = z,
        color = pheatmap.color("RdBu"),
        breaks = pheatmap.breaks(z),
        cluster_rows = pheatmap.cluster_rows(z),
        cluster_cols = pheatmap.cluster_cols(x),
        show_rownames = FALSE,
        show_colnames = FALSE,
        filename = output$pdf,
        width = 8,
        height = 6
    )

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log)