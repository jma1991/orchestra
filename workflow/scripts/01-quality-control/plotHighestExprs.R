#!/usr/bin/env Rscript


plotHighestExprs <- function(x) {

    mat <- counts(x)

    row <- rownames(mat)

    ave <- rowMeans(mat)
    
    idx <- order(ave, decreasing = TRUE)

    sel <- head(idx, n = 50)

    row <- row[sel]

    ave <- ave[sel]

    dat <- data.frame(mean = ave, name = row)

    dat$name <- with(dat, reorder(name, mean))

    ggplot(dat, aes(mean, name)) + 
        geom_segment(aes(x = 0, xend = mean, y = name, yend = name), colour = "#BAB0AC") + 
        geom_point(colour = "#79706E") + 
        labs(x = "Mean", y = "Feature") + 
        theme_classic()

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scater)

    sce <- readRDS(input$rds)

    plt <- plotHighestExprs(sce)

    ggsave(output$pdf, plot = plt, width = 4, height = 6, scale = 1)

}

main(snakemake@input, snakemake@output, snakemake@log)