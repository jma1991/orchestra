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

    mat <- embedVelocity(x = sce, vobj = vel, use.dimred = "PCA")
    
    vec <- gridVectors(x = sce, embedded = mat, scale = FALSE, use.dimred = "PCA")

    dat <- makePerCellDF(sce)

    dat <- as.data.frame(dat)

    plt <- ggplot(dat, aes(PCA.1, PCA.2)) + 
        geom_point(colour = "#BAB0AC") + 
        geom_segment(data = vec, 
            mapping = aes(x = start.PCA.1, y = start.PCA.2, xend = end.PCA.1, yend = end.PCA.2), 
            arrow = arrow(length = unit(0.05, "inches"), type = "closed")) + 
        labs(x = "PCA 1", y = "PCA 2") + 
        coord_fixed() + 
        theme_bw() + 

    ggsave(file = output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@wildcards)