#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(robustbase)

    library(scater)

    dat <- read.csv(input$csv)

    fit <- DataFrame(lib_size = log10(dat$sum), n_features = log10(dat$detected))

    adj <- adjOutlyingness(fit, only.outlyingness = TRUE)

    fit$discard <- isOutlier(adj, type = "higher")

    write.csv(fit, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@log)