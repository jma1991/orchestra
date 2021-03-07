#!/usr/bin/env Rscript

which_max <- function(x, n = 6) {
    which(x >= sort(x, decreasing = TRUE)[n], arr.ind = TRUE)
}

which_min <- function(x, n = 6) { 
    which(x <= sort(x, decreasing = FALSE)[n], arr.ind = TRUE)
}

theme_custom <- function() {

    # Return custom theme

    theme_bw() +
    theme(
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines"))
    )

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function
    
    library(ggplot2)

    library(ggrepel)
            
    res <- readRDS(input$rds)
    
    ind <- list(
        max = which_max(res$logFC, n = params$n), 
        min = which_min(res$logFC, n = params$n)
    )

    ids <- res$Symbol

    res$Symbol <- ""

    res$Symbol[ind$max] <- ids[ind$max]
    
    res$Symbol[ind$min] <- ids[ind$min]

    lim <- max(abs(res$logFC))

    dat <- as.data.frame(res)

    plt <- ggplot(dat, aes(logCPM, logFC, colour = Prop, label = Symbol)) + 
        geom_point() + 
        geom_text_repel(colour = "#000000", size = 1.94, segment.size = 0.25, max.overlaps = Inf, seed = 42) + 
        scale_colour_viridis_c(name = "Proportion", limits = c(0, 1)) + 
        scale_y_continuous(limits = c(-lim, lim)) + 
        labs(x = "Average Log Counts Per Million", y = "Log Fold Change [Pass / Fail]") + 
        theme_custom()

    ggsave(output$pdf, plot = plt, width = 8, heigh = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)