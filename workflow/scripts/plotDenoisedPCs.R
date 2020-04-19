#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds[1])

    num <- readRDS(input$rds[2])

    var <- attr(dim, "percentVar")
    
    pdf(output$pdf)

    plot(var, xlab = "Principal component (N)", ylab = "Variance explained (%)")
    
    abline(v = num, col = "red")

    dev.off()

}

main(snakemake@input, snakemake@output)