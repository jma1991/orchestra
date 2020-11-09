#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scran)

    dat <- readRDS(input$rds)

    num <- metadata(dat)$chosen

    plt <- ggplot(as.data.frame(dat), aes(n.pcs, n.clusters)) + 
        geom_point(colour = "#79706E") + 
        geom_abline(intercept = 1, slope = 1, colour = "#E15759") + 
        geom_vline(xintercept = num, colour = "#79706E", linetype = "dashed") + 
        labs(x = "Number of PCs", y = "Number of clusters") + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log)