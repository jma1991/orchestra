#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dim <- readRDS(input$rds[1])

    num <- readRDS(input$rds[2])

    var <- attr(dim, "percentVar")

    dat <- data.frame(component = seq_along(var), variance = as.numeric(var))

    plt <- ggplot(dat, aes(component, variance)) + 
        geom_point(colour = "#79706E") + 
        geom_vline(xintercept = as.numeric(num), colour = "#E15759") + 
        labs(x = "Principal component", y = "Varianced explained (%)") + 
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