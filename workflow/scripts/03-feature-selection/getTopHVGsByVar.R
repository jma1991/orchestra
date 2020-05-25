#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dec <- readRDS(input$rds)

    lgl <- "bio" %in% colnames(dec)  # check var or cv2 model

    var <- ifelse(lgl, "bio", "ratio")

    hvg <- getTopHVGs(dec, var.field = var, var.threshold = params$var)

    saveRDS(hvg, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)
