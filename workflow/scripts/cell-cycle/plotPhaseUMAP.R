#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scuttle)

    sce <- readRDS(input$rds)

    dat <- makePerCellDF(sce)

    dat <- as.data.frame(dat)

    col <- c("G1" = "#E03531", "S" = "#F0BD27", "G2M" = "#51B364")

    lab <- c("G1" = "G1", "S" = "S", "G2M" = "G2/M")

    brk <- c("G1", "S", "G2M")

    plt <- ggplot(dat, aes(UMAP.1, UMAP.2, colour = Phase)) + 
        geom_point() + 
        scale_colour_manual(values = col, labels = lab, breaks = brk) + 
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

main(snakemake@input, snakemake@output, snakemake@log)