#!/usr/bin/env Rscript

theme_custom <- function() {

    # Return custom theme

    theme_bw() +
    theme(
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
    )

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

    dat <- subset(dat, detected > 0)

    dat <- as.data.frame(dat)

    plt <- ggplot(dat, aes(x = detected)) + 
        geom_histogram(bins = 100, colour = "#BAB0AC", fill = "#BAB0AC") + 
        scale_x_continuous(name = "Detected", breaks = breaks_extended(), label = label_percent(scale = 1)) + 
        scale_y_continuous(name = "Frequency", breaks = breaks_extended(), label = label_number_si()) + 
        theme_custom()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)