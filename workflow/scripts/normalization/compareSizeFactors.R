#!/usr/bin/env Rscript

theme_custom <- function() {

    # Return custom theme

    theme_bw() +
    theme(
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
    )

}

main <- function(input, output, params, log, threads) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scales)

    dat <- data.frame(
        librarySizeFactors = readRDS(input$rds[1]),
        computeSumFactors = readRDS(input$rds[2])
    )

    plt <- ggplot(dat, aes(librarySizeFactors, computeSumFactors)) + 
        geom_point(size = 1, colour = "#BAB0AC") + 
        geom_abline(intercept = 0, slope = 1, colour = "#E15759") + 
        scale_x_continuous(name = "Library size factor", breaks = breaks_extended()) + 
        scale_y_continuous(name = "Deconvolution size factor", breaks = breaks_extended()) + 
        theme_custom()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log, snakemake@threads)