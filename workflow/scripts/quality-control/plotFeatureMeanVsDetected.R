#!/usr/bin/env Rscript

plotExprsFreqVsMean <- function(x, n = 10) {

    x <- subset(x, mean > 0)
    
    fit <- mgcv::gam(x$detected ~ s(log10(x$mean), bs = "cs"))
    
    idx <- which(abs(fit$residuals) >= sort(abs(fit$residuals), decreasing = TRUE)[n], arr.ind = TRUE)
    
    x$name <- ""
    
    x$name[idx] <- rownames(x)[idx]
    
    plt <- ggplot(as.data.frame(x), aes(mean, detected, label = name)) + 
        geom_point(colour = ifelse(x$name == "", "#BAB0AC", "#E15759")) + 
        geom_text_repel() + 
        scale_x_log10(name = "Mean", breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x))) + scale_y_continuous(name = "Detected", labels = label_percent(scale = 1)) + 
        theme_bw()

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(ggrepel)

    library(scales)

    dat <- readRDS(input$rds)

    plt <- plotExprsFreqVsMean(dat)

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)