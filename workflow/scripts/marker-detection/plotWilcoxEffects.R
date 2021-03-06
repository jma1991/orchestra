#!/usr/bin/env Rscript

pheatmap.mat <- function(x) {

    # Return list of numeric matrix of the values to be plotted

    lapply(x, getMarkerEffects, prefix = "AUC")

}

pheatmap.color <- function(x) {

    # Return vector of colors used in heatmap
    
    viridis::viridis(100)

}

pheatmap.breaks <- function(x) {

    # Return vector of breaks used in heatmap

    seq(0, 1, length.out = 101)

}

pheatmap.cluster_rows <- function(x) {

    # Return vector of boolean values determining if rows should be clustered

    sapply(x, nrow) > 1

}

pheatmap.labels_row <- function(x) {

    # Return list of custom labels for rows that are used instead of rownames

    lapply(x, "[[", "gene.name")

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(pheatmap)

    library(scran)

    res <- readRDS(input$rds)

    sig <- lapply(res, subset, FDR < 0.05)

    sig <- lapply(sig, head, n = 50)

    sig <- Filter(nrow, sig)

    if (length(sig) == 0) {

        dir.create(output$dir) # create empty output file
        
        return(invisible()) # return nothing

    }

    dir <- dir.create(output$dir)

    ids <- paste0(output$dir, "/", names(sig), ".pdf")

    arg <- list(
        color = pheatmap.color("RdBu"), 
        breaks = pheatmap.breaks(5), 
        border_color = "#FFFFFF",
        angle_col = 0, 
        width = 6, 
        height = 8
    )

    plt <- mapply(
        FUN = pheatmap, 
        mat = pheatmap.mat(sig), 
        cluster_rows = pheatmap.cluster_rows(sig), 
        labels_row = pheatmap.labels_row(sig), 
        filename = ids, 
        MoreArgs = arg
    )

}

main(snakemake@input, snakemake@output, snakemake@log)