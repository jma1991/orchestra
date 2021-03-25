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

    library(ggforce)

    library(ggplot2)

    obj <- readRDS(input$rds)

    dat <- as.data.frame(obj)

    dat$closest <- ifelse(dat$width > 0, dat$cluster, dat$other)

    dat$closest <- factor(dat$closest)

    plt <- ggplot(dat, aes(cluster, jitter(width), colour = closest, group = cluster)) + 
        geom_sina() + 
        labs(x = "Cluster", y = "Silhouette width", colour = "Closest") + 
        theme_custom()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)