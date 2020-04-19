#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("robustbase", "scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)
    
    mat <- cbind(
        sum = log10(dat$sum),
        detected = log10(dat$detected)
    )
    
    adj <- adjOutlyingness(mat, only.outlyingness = TRUE)
    
    lgl <- isOutlier(adj, type = "higher")

    out <- DataFrame(discard = lgl)

    saveRDS(dat, output$rds)

}

main(snakemake@input, snakemake@output)