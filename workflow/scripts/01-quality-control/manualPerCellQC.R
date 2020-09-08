#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")
    
    # Script function

    library(scater)

    dat <- read.csv(input$csv)
    
    fit <- DataFrame(
        low_lib_size = dat$sum <= 2500,
        low_n_features = dat$detected <= 200
    )

    fit$discard <- apply(fit, 1, any)

    write.csv(fit, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@log)