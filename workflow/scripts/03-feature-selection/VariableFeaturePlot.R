#!/usr/bin/env Rscript

hvg.color <- function(x) {

    # Legend color

    x.col <- "#E15759"

    y.col <- "#BAB0AC"

    c("TRUE" = x.col, "FALSE" = y.col)

}

hvg.label <- function(x) {
    
    # Variable label

    x.sum <- sum(x == TRUE)

    x.pct <- x.sum / length(x)

    x.lab <- paste0("Variable: ", scales::comma(x.sum), " (", scales::percent(x.pct), ")")
 
    # Non-variable label

    y.sum <- sum(x == FALSE)

    y.pct <- y.sum / length(x)

    y.lab <- paste0("Non-variable: ", scales::comma(y.sum), " (", scales::percent(y.pct), ")")

    # Legend label

    c("TRUE" = x.lab, "FALSE" = y.lab)

}

main <- function(input, output) {

    library(ggplot2)
    
    dec <- read.csv(input$csv, row.names = 1)

    hvg <- readLines(input$txt)

    dec$HVG <- rownames(dec) %in% hvg

    col <- hvg.color(dec$HVG)

    lab <- hvg.label(dec$HVG)

    plt <- ggplot(dec, aes(mean, total, colour = HVG)) + 
        geom_point(size = 1) + 
        scale_colour_manual(values = col, labels = lab) + 
        labs(x = "Mean of log-expression", y = "Variance of log-expression") + 
        theme_bw() + 
        theme(
            axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
            axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
            legend.title = element_blank(),
            legend.position = "top"
        )

    ggsave(output$pdf, plot = plt, width = 6, height = 4.5)

}

main(snakemake@input, snakemake@output)