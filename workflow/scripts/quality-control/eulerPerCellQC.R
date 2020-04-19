#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("eulerr")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- lapply(input$rds, readRDS)
    
    mat <- cbind(
        Total    = TRUE,
        Manual   = dat[[1]]$discard, 
        Adaptive = dat[[2]]$discard, 
        Outlier  = dat[[3]]$discard,
    )
    
    fit <- euler(mat)

    plt <- plot(fit, quantities = list(type = c("percent", "counts")))

    pdf(output$pdf)
    
    print(plt)

    dev.off()

}

main(snakemake@input, snakemake@output)