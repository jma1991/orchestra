#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(ggforce)

    dim <- readRDS(input$rds)

    dat <- lapply(dim, function(x) {

        y <- as.data.frame(x)

        y$n_neighbors <- attr(x, "n_neighbors")

        y$min_dist <- attr(x, "min_dist")

        return(y)

    })

    dat <- do.call(rbind, dat)

    plt <- ggplot(dat, aes(V1, V2)) + 
        geom_point(size = 0.1) + 
        facet_wrap(n_neighbors ~ min_dist, scales = "free") + 
        theme_no_axes(theme_bw()) + theme(aspect.ratio = 1)

    ggsave(output$pdf, plot = plt, width = 12, height = 12, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)