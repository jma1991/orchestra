#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(patchwork)

    library(ggbeeswarm)

    dat <- lapply(input$csv, read.csv)

    dat <- do.call(cbind, dat)

    pal <- c('TRUE' = "#E15759", 'FALSE' = "#59A14F")

    plt <- list(

        p1 = ggplot(dat, aes(x = "Sample", y = sum, colour = discard)) + 
                geom_quasirandom() + 
                scale_colour_manual(values = pal) + 
                scale_y_log10() + 
                labs(x = "Sample", y = "Sum"),
        
        p2 = ggplot(dat, aes(x = "Sample", y = detected, colour = discard)) + 
                geom_quasirandom() + 
                scale_colour_manual(values = pal) + 
                scale_y_log10() + 
                labs(x = "Sample", y = "Detected")
        
    )

    plt <- wrap_plots(plt, guides = "collect") & theme_classic()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)