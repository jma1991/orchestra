#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    pct <- vector()

    if (!is.null(params$alt)) {
        
        alt <- paste("altexps", params$alt, "percent", sep = "_")
        
        pct <- append(pct, alt) 
    
    }

    if (!is.null(params$sub)) {
        
        sub <- paste("subsets", params$sub, "percent", sep = "_")
        
        pct <- append(pct, alt)
    
    }

    fit <- quickPerCellQC(dat, percent_subsets = pct)

    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)