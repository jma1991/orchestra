#!/usr/bin/env Rscript

main <- function(input, output, log, wildcards) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dat <- lapply(input$csv, read.csv)

    dat <- do.call(cbind, dat)

    lab <- labeller(
        discard = c("TRUE" = "Fail", "FALSE" = "Pass")
    )

    plt <- ggplot(dat, aes_string("PC1", "PC2", colour = wildcards$metric)) + 
        geom_point() + 
        scale_colour_viridis_c() + 
        labs(x = "PC 1", y = "PC 2") + 
        coord_fixed() + 
        facet_wrap(~ discard, labeller = lab) + 
        theme_bw()

    ggsave(file = output$pdf, plot = plt, width = 4, height = 3, scale = 1.5)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@wildcards)