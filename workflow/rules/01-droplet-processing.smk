# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule barcodeRanks:
    input:
        rds = "analysis/01-droplet-processing/SingleCellExperiment.rds"
    output:
        rds = "analysis/01-droplet-processing/barcodeRanks.rds"
    log:
        out = "analysis/01-droplet-processing/barcodeRanks.out",
        err = "analysis/01-droplet-processing/barcodeRanks.err"
    message:
        "[Droplet processing] Calculate barcode ranks"
    script:
        "../scripts/01-droplet-processing/barcodeRanks.R"

rule barcodeRanksPlot:
    input:
        rds = "analysis/01-droplet-processing/barcodeRanks.rds"
    output:
        pdf = "analysis/01-droplet-processing/barcodeRanksPlot.pdf"
    log:
        out = "analysis/01-droplet-processing/barcodeRanksPlot.out",
        err = "analysis/01-droplet-processing/barcodeRanksPlot.err"
    message:
        "[Droplet processing] Plot barcode ranks"
    script:
        "../scripts/01-droplet-processing/barcodeRanksPlot.R"

rule emptyDrops:
    input:
        rds = "analysis/01-droplet-processing/SingleCellExperiment.rds"
    output:
        rds = "analysis/01-droplet-processing/emptyDrops.rds"
    log:
        out = "analysis/01-droplet-processing/emptyDrops.out",
        err = "analysis/01-droplet-processing/emptyDrops.err"
    message:
        "[Droplet processing] Identify empty droplets"
    script:
        "../scripts/01-droplet-processing/emptyDrops.R"

rule emptyDrops1:
    input:
        rds = "analysis/01-droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/01-droplet-processing/emptyDrops1.pdf"
    log:
        out = "analysis/01-droplet-processing/emptyDrops1.out",
        err = "analysis/01-droplet-processing/emptyDrops1.err"
    message:
        "[Droplet processing] Plot ambient barcodes"
    script:
        "../scripts/01-droplet-processing/emptyDrops1.R"

rule emptyDrops2:
    input:
        rds = "analysis/01-droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/01-droplet-processing/emptyDrops2.pdf"
    log:
        out = "analysis/01-droplet-processing/emptyDrops2.out",
        err = "analysis/01-droplet-processing/emptyDrops2.err"
    message:
        "[Droplet processing]"
    script:
        "../scripts/01-droplet-processing/emptyDrops2.R"

rule emptyDrops3:
    input:
        rds = "analysis/01-droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/01-droplet-processing/emptyDrops3.pdf"
    log:
        out = "analysis/01-droplet-processing/emptyDrops3.out",
        err = "analysis/01-droplet-processing/emptyDrops3.err"
    message:
        "[Droplet processing]"
    script:
        "../scripts/01-droplet-processing/emptyDrops3.R"

rule filterDrops:
    input:
        rds = ["analysis/01-droplet-processing/SingleCellExperiment.rds", "analysis/01-droplet-processing/emptyDrops.rds"]
    output:
        rds = "analysis/01-droplet-processing/filterDrops.rds"
    log:
        out = "analysis/01-droplet-processing/filterDrops.out",
        err = "analysis/01-droplet-processing/filterDrops.err"
    message:
        "[Droplet processing] Filter empty droplets"
    script:
        "../scripts/01-droplet-processing/filterDrops.R"