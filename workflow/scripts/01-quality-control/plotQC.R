#!/usr/bin/env Rscript

main <- function(input, output, log, wildcards) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(ggbeeswarm)

    dat <- lapply(input$csv, read.csv)

    dat <- do.call(cbind, dat)

    dat[[wildcards$metric]] <- log10(dat[[wildcards$metric]])

    col <- c("TRUE" = "#E15759", "FALSE" = "#59A14F")

    lab <- c("TRUE" = "Fail", "FALSE" = "Pass")

    plt <- ggplot(dat, aes_string("discard", wildcards$metric, colour = "discard")) + 
        geom_quasirandom(show.legend = FALSE) + 
        scale_colour_manual(values = col) + 
        scale_x_discrete(labels = lab) + 
        labs(x = "Quality control") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@wildcards)