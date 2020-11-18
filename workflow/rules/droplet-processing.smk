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
    log:
        out = "analysis/droplet-processing/barcodeRanksPlot.out",
        err = "analysis/droplet-processing/barcodeRanksPlot.err"
    message:
        "[Droplet processing] Plot barcode ranks"
    script:
        "../scripts/droplet-processing/barcodeRanksPlot.R"

rule emptyDrops1:
    input:
        rds = "analysis/droplet-processing/SingleCellExperiment.rds"
    output:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    params:
        lower = 100,
        niters = 10000
    log:
        out = "analysis/droplet-processing/emptyDrops.out",
        err = "analysis/droplet-processing/emptyDrops.err"
    message:
        "[Droplet processing] Identify empty droplets"
    script:
        "../scripts/droplet-processing/emptyDrops.R"

rule emptyDrops2:
    input:
        rds = "analysis/droplet-processing/SingleCellExperiment.rds"
    output:
        rds = "analysis/droplet-processing/emptyDrops.ambient.rds"
    params:
        lower = 100,
        niters = 10000
    log:
        out = "analysis/droplet-processing/emptyDrops.ambient.out",
        err = "analysis/droplet-processing/emptyDrops.ambient.err"
    message:
        "[Droplet processing] Identify empty droplets (test.ambient = TRUE)"
    script:
        "../scripts/droplet-processing/emptyDrops.ambient.R"

rule emptyDropsLimited:
    input:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsLimited.pdf"
    params:
        FDR = 0.05
    log:
        out = "analysis/droplet-processing/emptyDropsLimited.out",
        err = "analysis/droplet-processing/emptyDropsLimited.err"
    message:
        "[Droplet processing] Plot droplet limited"
    script:
        "../scripts/droplet-processing/emptyDropsLimited.R"

rule emptyDropsLogProb:
    input:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsLogProb.pdf"
    params:
        FDR = 0.05
    log:
        out = "analysis/droplet-processing/emptyDropsLogProb.out",
        err = "analysis/droplet-processing/emptyDropsLogProb.err"
    message:
        "[Droplet processing] Plot droplet log probability"
    script:
        "../scripts/droplet-processing/emptyDropsLogProb.R"

rule emptyDropsRank:
    input:
        rds = "analysis/droplet-processing/emptyDrops.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsRank.pdf"
    params:
        FDR = 0.05
    log:
        out = "analysis/droplet-processing/emptyDropsRank.out",
        err = "analysis/droplet-processing/emptyDropsRank.err"
    message:
        "[Droplet processing] Plot droplet rank"
    script:
        "../scripts/droplet-processing/emptyDropsRank.R"

rule emptyDropsPValue:
    input:
        rds = "analysis/droplet-processing/emptyDrops.ambient.rds"
    output:
        pdf = "analysis/droplet-processing/emptyDropsPValue.pdf"
    log:
        out = "analysis/droplet-processing/emptyDropsPValue.out",
        err = "analysis/droplet-processing/emptyDropsPValue.err"
    message:
        "[Droplet processing] Plot droplet P-value"
    script:
        "../scripts/droplet-processing/emptyDropsPValue.R"

rule filterByDrops:
    input:
        rds = ["analysis/droplet-processing/SingleCellExperiment.rds", "analysis/droplet-processing/emptyDrops.rds"]
    output:
        rds = "analysis/droplet-processing/filterByDrops.rds"
    params:
        FDR = 0.05
    log:
        out = "analysis/droplet-processing/filterByDrops.out",
        err = "analysis/droplet-processing/filterByDrops.err"
    message:
        "[Droplet processing] Filter droplets by {params.FDR} FDR threshold"
    script:
        "../scripts/droplet-processing/filterByDrops.R"