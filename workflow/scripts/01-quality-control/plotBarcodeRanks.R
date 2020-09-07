#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    dat <- read.csv(input$csv)

    dat <- dat[!duplicated(dat$rank), ] # only show unique points for plotting speed

    plt <- ggplot(dat, aes(rank, total)) + geom_point(colour = "#BAB0AC") + scale_x_log10() + scale_y_log10() + labs(x = "Rank", y = "Total UMI count") + theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6)

}

main(snakemake@input, snakemake@output)