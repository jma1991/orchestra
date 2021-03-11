#!/usr/bin/env Rscript

theme_custom <- function() {

    # Return custom theme

    theme_no_axes() +
    theme(
        aspect.ratio = 1,
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
        strip.background = element_blank()
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

    library(scuttle)

    sce <- readRDS(input$rds)

    dat <- makePerCellDF(sce)

    dat <- as.data.frame(dat)

    lab <- c("G1" = "G1", "S" = "S", "G2M" = "G2/M")

    col <- c("G1" = "#E03531", "S" = "#F0BD27", "G2M" = "#51B364")

    dat$Phase <- factor(dat$Phase, levels = c("G1", "S", "G2M"))

    plt <- ggplot(dat, aes(TSNE.1, TSNE.2, colour = Phase)) + 
        geom_point(data = dat[, c("TSNE.1", "TSNE.2")], aes(TSNE.1, TSNE.2), colour = "#BAB0AC") + 
        geom_point(show.legend = FALSE) + 
        scale_colour_manual(labels = lab, values = col) + 
        labs(x = "TSNE 1", y = "TSNE 2") + 
        facet_wrap(~ Phase) + 
        theme_custom()

    ggsave(file = output$pdf, plot = plt, width = 8, height = 4, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)