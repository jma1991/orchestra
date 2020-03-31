#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c()

    lib <- lapply(pkg, library, character.only = TRUE)

    fit <- readRDS(input$rds)
    
    num <- tabulate(fit$cluster)
    
    dat <- data.frame(
        wcss = fit$withinss, 
        ncell = num, 
        rms = sqrt(fit$withinss / num)
    )

    write.csv(dat, file = output$csv)

}

main(snakemake@input, snakemake@output)