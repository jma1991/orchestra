#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("ggplot2")

    lib <- lapply(pkg, library, character.only = TRUE)

    run <- readRDS(input$rds)

    dim <- lapply(run, "[[", "Y")

    num <- sapply(run, "[[", "perplexity")

    dst <- sapply(run, "[[", "max_iter")

    dat <- as.data.frame(do.call(rbind, dim))

    dat$perplexity <- rep(num, each = nrow(dim[[1]]))
    
    dat$max_iter <- rep(dst, each = nrow(dim[[1]]))
    
    plt <- ggplot(dat, aes(V1, V2)) + 
        geom_point() + 
        facet_grid(perplexity ~ max_iter, scales = "free", switch = "y") + 
        theme(aspect.ratio = 1, strip.text.y.left = element_text(angle = 0))

    ggsave(output$pdf, plot = plt, width = 8, height = 6)

}

main(snakemake@input, snakemake@output)