#!/usr/bin/env Rscript

breaks_log10 <- function(x) {

    # Return breaks for log10 axes

    10^seq(floor(log10(min(x))), ceiling(log10(max(x))))

}

labels_log10 <- function(x) {

    # Return labels for log10 axes

    options(scipen = 999)

    signif(x, digits = Inf)

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scales)

    dat <- readRDS(input$rds)

    plt <- ggplot(as.data.frame(dat), aes(mean)) + 
        geom_histogram(bins = 50, colour = "#849db1", fill = "#849db1") + 
        scale_x_log10(name = "Mean counts", breaks = breaks_log10, labels = labels_log10) + 
        scale_y_continuous(name = "Number of features", breaks = breaks_extended(), label = label_number_si()) + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)