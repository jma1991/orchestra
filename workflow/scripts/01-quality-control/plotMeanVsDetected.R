#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    library(scales)

    dat <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dat, aes(mean, detected)) + 
        geom_point(
            alpha = 0.1,
            colour = "#7F7F7F"
        ) + 
        geom_smooth(
            colour = "#D62728",
            se = FALSE
        ) + 
        scale_x_log10(
            name = "Mean count",
            breaks = trans_breaks("log10", function(x) 10^x),
            labels = trans_format("log10", math_format(10^.x))
        ) + 
        scale_y_continuous(
            name = "Detected (%)",
            n.breaks = 10
        ) + 
        annotation_logticks(
            side = "b"
        ) + 
        theme_classic() + 
        theme(
            aspect.ratio = 1,
            axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
            axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines"))
        )

    ggsave(output$pdf, plot = plt, width = 4, height = 4)

}

main(snakemake@input, snakemake@output)