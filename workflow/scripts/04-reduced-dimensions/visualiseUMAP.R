#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("ggplot2")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    dat <- lapply(dim, function(m) {

        d <- as.data.frame(m)

        d$n_neighbors <- attr(m, "n_neighbors")

        d$min_dist <- attr(m, "min_dist")

        return(d)

    })

    dat <- do.call("rbind", dat)

    plt <- ggplot(dat, aes(V1, V2)) + 
        geom_point() + 
        facet_grid(n_neighbors ~ min_dist, scales = "free", switch = "y") + 
        theme(aspect.ratio = 1, strip.text.y.left = element_text(angle = 0))

    ggsave(output$pdf, plot = plt, width = 16, height = 9)

}

main(snakemake@input, snakemake@output)