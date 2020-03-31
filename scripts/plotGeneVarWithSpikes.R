#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dec <- readRDS(input$rds)

    fit <- metadata(dec)

    pdf(output$pdf)
    
    plot(dec$mean, dec$total, pch = 19, xlab = "Mean of log-expression", ylab = "Variance of log-expression")
    
    points(fit$mean, fit$var, pch = 19, col = "red")
    
    curve(fit$trend(x), col = "red", add = TRUE, lwd = 2)

    legend("topright", legend = params$alt, pch = 19, col = "red")

    dev.off()

}

main(snakemake@input, snakemake@output, snakemake@params)