#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("ggplot2")

    lib <- lapply(pkg, library, character.only = TRUE)

    run <- readRDS(input$rds)

    dim <- lapply(run, "[[", "embedding")

    num <- sapply(run, "[[", "n_neighbors")

    dst <- sapply(run, "[[", "min_dist")

    dat <- as.data.frame(do.call(rbind, dim))

    dat$n_neighbors <- rep(num, each = nrow(dim[[1]]))
    
    dat$min_dist <- rep(dst, each = nrow(dim[[1]]))
    
    plt <- ggplot(dat, aes(V1, V2)) + 
        geom_point() + 
        facet_grid(n_neighbors ~ min_dist, scales = "free", switch = "y") + 
        theme(aspect.ratio = 1, strip.text.y.left = element_text(angle = 0))

    ggsave(output$pdf, plot = plt, width = 8, height = 6)

}

main(snakemake@input, snakemake@output)