#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(ggrepel)

    dec <- readRDS(input$rds)

    dec$name <- ""

    ind <- which(dec$bio >= sort(dec$bio, decreasing = TRUE)[10], arr.ind = TRUE)

    dec$name[ind] <- rownames(dec)[ind]

    plt <- ggplot(as.data.frame(dec)) + 
        geom_point(aes(x = mean, y = total), colour = "#BAB0AC") + 
        geom_line(aes(x = mean, y = tech), colour = "#E15759") + 
        geom_text_repel(aes(x = mean, y = total, label = name), colour = "#000000", size = 1) + 
        labs(x = "Mean", y = "Total") + 
        theme_bw()
    
    ggsave(filename = output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log)