#!/usr/bin/env Rscript

values <- function(x) {

    # Legend color

    x.col <- "#E15759"

    y.col <- "#BAB0AC"

    c("TRUE" = x.col, "FALSE" = y.col)

}

labels <- function(x) {
    
    # Variable label

    x.sum <- sum(x, na.rm = TRUE)

    x.pct <- x.sum / length(x)

    x.lab <- paste0("Variable: ", scales::comma(x.sum), " (", scales::percent(x.pct), ")")
 
    # Non-variable label

    y.sum <- length(x) - x.sum

    y.pct <- y.sum / length(x)

    y.lab <- paste0("Non-variable: ", scales::comma(y.sum), " (", scales::percent(y.pct), ")")

    # Legend label

    c("TRUE" = x.lab, "FALSE" = y.lab)

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)
    
    dec <- read.csv(input$csv, row.names = 1)

    hvg <- readLines(input$txt)

    dec$hvg <- rownames(dec) %in% hvg

    plt <- ggplot(dec, aes(mean, total, colour = hvg)) + 
        geom_point(size = 1) + 
        scale_colour_manual(values = values(dec$hvg), labels = labels(dec$hvg)) + 
        labs(x = "Mean of log-expression", y = "Variance of log-expression") + 
        theme_bw() + 
        theme(legend.title = element_blank(), legend.position = "top")

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)