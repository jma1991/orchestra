# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule barcodeRanks:
    input:
        rds = "analysis/droplet-processing/SingleCellExperiment.rds"
    output:
        rds = "analysis/droplet-processing/barcodeRanks.rds"
    params:
        lower = 100
    log:
        out = "analysis/droplet-processing/barcodeRanks.out",
        err = "analysis/droplet-processing/barcodeRanks.err"
    message:
        "[Droplet processing] Calculate barcode ranks"
    script:
        "../scripts/droplet-processing/barcodeRanks.R"

rule barcodeRanksPlot:
    input:
        rds = "analysis/droplet-processing/barcodeRanks.rds"
    output:
        pdf = "analysis/droplet-processing/barcodeRanksPlot.pdf"
    params:
        lower = 100
    log:
        out = "analysis/droplet-processing/barcodeRanksPlot.out",
        err = "analysis/droplet-processing/barcodeRanksPlot.err"
    message:
        "[Droplet processing] Plot barcode ranks"
    script:
        "../scripts/droplet-processing/barcodeRanksPlot.R"

rule emptyDrops:
    input:
        rds = "analysis/droplet-processing/SingleCellExperiment.rds"
    output:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    params:
        lower = 100
    log:
        out = "analysis/droplet-processing/emptyDrops.out",
        err = "analysis/droplet-processing/emptyDrops.err"
    message:
        "[Droplet processing] Identify empty droplets"
    script:
        "../scripts/droplet-processing/emptyDrops.R"

rule emptyDropsPval:
    input:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsPval.pdf"
    params:
        lower = 100
    log:
        out = "analysis/droplet-processing/emptyDropsPval.out",
        err = "analysis/droplet-processing/emptyDropsPval.err"
    message:
        "[Droplet processing] Plot empty droplet P-value"
    script:
        "../scripts/droplet-processing/emptyDropsPval.R"

rule emptyDropsProb:
    input:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsProb.pdf"
    params:
        fdr = 0.05
    log:
        out = "analysis/droplet-processing/emptyDropsProb.out",
        err = "analysis/droplet-processing/emptyDropsProb.err"
    message:
        "[Droplet processing] Plot empty droplet log probability"
    script:
        "../scripts/droplet-processing/emptyDropsProb.R"

rule emptyDropsRank:
    input:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsRank.pdf"
    params:
        fdr = 0.05
    log:
        out = "analysis/droplet-processing/emptyDropsRank.out",
        err = "analysis/droplet-processing/emptyDropsRank.err"
    message:
        "[Droplet processing] Plot empty droplet rank"
    script:
        "../scripts/droplet-processing/emptyDropsRank.R"

rule filterByDrops:
    input:
        rds = ["analysis/droplet-processing/SingleCellExperiment.rds", "analysis/droplet-processing/emptyDrops.rds"]
    output:
        rds = "analysis/droplet-processing/filterByDrops.rds"
    params:
        fdr = 0.05
    log:
        out = "analysis/droplet-processing/filterByDrops.out",
        err = "analysis/droplet-processing/filterByDrops.err"
    message:
        "[Droplet processing] Filter empty droplets"
    script:
        "../scripts/droplet-processing/filterByDrops.R"