#!/usr/bin/env Rscript

main <- function(input, output) {
    
    pkg <- installed.packages()
    
    ver <- pkg[, "Version"]

    dat <- data.frame(name = names(ver), version = ver)

    write.csv(dat, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output)