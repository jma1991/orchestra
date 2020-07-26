#!/usr/bin/env Rscript

main <- function(input, output) {
    
    library(RclusTool)
    
    var <- readLines(input$txt)
    
    idx <- seq_along(var)
    
    num <- ElbowFinder(idx, as.numeric(var))

    writeLines(num, con = output$txt)

}

main(snakemake@input, snakemake@output)