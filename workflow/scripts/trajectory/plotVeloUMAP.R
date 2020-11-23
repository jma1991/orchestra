#!/usr/bin/env Rscript

main <- function(input, output, log, wildcards) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scuttle)

    library(velociraptor)

    sce <- readRDS(input$rds[1])

    vel <- readRDS(input$rds[2])

    use <- Reduce(intersect, list(colnames(sce), colnames(vel)))

    sce <- sce[, use]

    vel <- vel[, use]

    mat <- embedVelocity(x = sce, vobj = vel, use.dimred = "UMAP")
    
    vec <- gridVectors(x = sce, embedded = mat, resolution = 100, use.dimred = "UMAP")

    dat <- makePerCellDF(sce)

    dat <- as.data.frame(dat)

    dat$Pseudotime <- vel$velocity_pseudotime

    plt <- ggplot(dat, aes(UMAP.1, UMAP.2, colour = Pseudotime)) + 
        geom_point() + 
        scale_colour_viridis_c() + 
        geom_segment(
            data = vec, 
            mapping = aes(x = start.UMAP.1, y = start.UMAP.2, xend = end.UMAP.1, yend = end.UMAP.2), 
            arrow = arrow(length = unit(0.02, "inches"), type = "closed"),
            inherit.aes = FALSE,
        ) + 
        labs(x = "UMAP 1", y = "UMAP 2") + 
        theme_bw() + 
        theme(aspect.ratio = 1)

    ggsave(file = output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@wildcards)