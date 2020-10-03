#!/usr/bin/env Rscript

var.field <- function(x) {

    # Identify the relevant metric of variation

    x <- "bio" %in% colnames(x)

    x <- ifelse(x, "bio", "ratio")

}

colour.values <- function(x) {

    # Define the colour values

    x.col <- "#E15759"

    y.col <- "#BAB0AC"

    c("TRUE" = x.col, "FALSE" = y.col)

}

colour.labels <- function(x) {
    
    # Define the colour labels

    x.sum <- sum(x, na.rm = TRUE)

    x.pct <- x.sum / length(x)

    x.lab <- paste0("Variable: ", scales::comma(x.sum), " (", scales::percent(x.pct), ")")
 
    y.sum <- length(x) - x.sum

    y.pct <- y.sum / length(x)

    y.lab <- paste0("Non-variable: ", scales::comma(y.sum), " (", scales::percent(y.pct), ")")

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

    dec$status <- rownames(dec) %in% readLines(input$txt)

    plt <- ggplot(dec, aes(mean, total, colour = status)) + 
        geom_point() + 
        scale_colour_manual(values = colour.values(dec$status), labels = colour.labels(dec$status)) + 
        theme_bw() + theme(legend.title = element_blank(), legend.position = "top")

    if ( var.field(dec) == "bio" ) plt <- plt + labs(x = "Mean of log-expression", y = "Variance of log-expression")  

    if ( var.field(dec) == "ratio" ) plt <- plt + scale_x_log10() + scale_y_log10() + labs(x = "Mean of log-expression", y = "Coefficient of variation")

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)