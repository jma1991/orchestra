# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule barcodeRanks:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds"
    output:
        csv = "analysis/01-quality-control/barcodeRanks.csv"
    log:
        out = "analysis/01-quality-control/barcodeRanks.out",
        err = "analysis/01-quality-control/barcodeRanks.err"
    message:
        "[Quality Control] Calculate barcode ranks"
    script:
        "../scripts/01-quality-control/barcodeRanks.R"

rule barcodePlots:
    input:
        csv = "analysis/01-quality-control/barcodeRanks.csv"
    output:
        pdf = "analysis/01-quality-control/barcodePlots.pdf"
    log:
        out = "analysis/01-quality-control/barcodePlots.out",
        err = "analysis/01-quality-control/barcodePlots.err"
    message:
        "[Quality Control] Plot barcode ranks"
    script:
        "../scripts/01-quality-control/barcodePlots.R"

rule emptyDrops:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds"
    output:
        csv = "analysis/01-quality-control/emptyDrops.csv"
    log:
        out = "analysis/01-quality-control/emptyDrops.out",
        err = "analysis/01-quality-control/emptyDrops.err"
    message:
        "[Quality Control] Identify empty droplets"
    script:
        "../scripts/01-quality-control/emptyDrops.R"

rule emptyDrops1:
    input:
        csv = "analysis/01-quality-control/emptyDrops.csv"
    output:
        pdf = "analysis/01-quality-control/emptyDrops1.pdf"
    log:
        out = "analysis/01-quality-control/emptyDrops1.out",
        err = "analysis/01-quality-control/emptyDrops1.err"
    message:
        "[Quality Control] Plot p-values for empty droplets"
    script:
        "../scripts/01-quality-control/emptyDrops1.R"

rule emptyDrops2:
    input:
        csv = "analysis/01-quality-control/emptyDrops.csv"
    output:
        pdf = "analysis/01-quality-control/emptyDrops2.pdf"
    log:
        out = "analysis/01-quality-control/emptyDrops2.out",
        err = "analysis/01-quality-control/emptyDrops2.err"
    message:
        "[Quality Control] Plot empty droplets"
    script:
        "../scripts/01-quality-control/emptyDrops2.R"

rule emptyDrops3:
    input:
        csv = "analysis/01-quality-control/emptyDrops.csv"
    output:
        pdf = "analysis/01-quality-control/emptyDrops3.pdf"
    log:
        out = "analysis/01-quality-control/emptyDrops3.out",
        err = "analysis/01-quality-control/emptyDrops3.err"
    message:
        "[Quality Control] Plot empty droplets"
    script:
        "../scripts/01-quality-control/emptyDrops3.R"








rule filterEmptyDrops:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds",
        csv = "analysis/01-quality-control/testEmptyDrops.csv"
    output:
        rds = "analysis/01-quality-control/TENxPBMCData.filteremptyDrops.rds"
    params:
        FDR = 0.01
    message:
        "[Quality Control] Filter empty droplets"
    script:
        "../scripts/01-quality-control/filterEmptyDrops.R"

rule perCellQCMetrics:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds"
    output:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    params:
        sub = config["subsets"]
    message:
        "[Quality Control] Compute per-cell quality control metrics"
    script:
        "../scripts/01-quality-control/perCellQCMetrics.R"

rule plotCellSum:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotCellSum.pdf"
    message:
        "[Quality Control] Plot the sum of counts for each cell"
    script:
        "../scripts/01-quality-control/plotCellSum.R"

rule plotCellDetected:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotCellDetected.pdf"
    message:
        "[Quality Control] Plot the number of observations above detection limit"
    script:
        "../scripts/01-quality-control/plotCellDetected.R"

rule plotCellSubset:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotCellSubset.{sub}.pdf"
    params:
        sub = "subsets_{sub}_percent"
    message:
        "[Quality Control] Plot the percentage of counts assigned to {wildcards.sub} subset for each cell"
    script:
        "../scripts/01-quality-control/plotCellSubset.R"

rule plotCellAltexp:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotCellAltExp.{alt}.pdf"
    params:
        alt = "altexps_{alt}_percent"
    message:
        "[Quality Control] Plot the percentage of counts assigned to {wildcards.alt} altexps for each cell"
    script:
        "../scripts/01-quality-control/plotCellAltexp.R"

rule plotColData:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotColData.{x}.{y}.pdf"
    message:
        "[Quality Control] Plot {wildcards.x} against {wildcards.y}"
    script:
        "../scripts/01-quality-control/plotColData.R"

rule fixedPerCellQC:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        csv = "analysis/01-quality-control/fixedPerCellQC.csv"
    params:
        alt = "Spikes"
    script:
        "../scripts/01-quality-control/fixedPerCellQC.R"

rule quickPerCellQC:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        csv = "analysis/01-quality-control/quickPerCellQC.csv"
    params:
        alt = expand("altexps_{alt}_percent", alt = config["altexps"]),
        sub = expand("subsets_{sub}_percent", sub = config["subsets"])
    message:
        "[Quality Control] Identify low-quality cells based on QC metrics"
    script:
        "../scripts/01-quality-control/quickPerCellQC.R"

rule adjOutlyingness:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        csv = "analysis/01-quality-control/adjOutlyingness.csv"
    params:
        alt = expand("altexps_{alt}_percent", alt = config["altexps"]),
        sub = expand("subsets_{sub}_percent", sub = config["subsets"])
    message:
        "[Quality Control] Identify outliers based on the per-cell quality control metrics"
    script:
        "../scripts/01-quality-control/adjOutlyingness.R"

rule eulerPerCellQC:
    input:
        csv = expand("analysis/01-quality-control/{object}.csv", object = ["fixedPerCellQC", "quickPerCellQC", "adjOutlyingness"])
    output:
        pdf = "analysis/01-quality-control/eulerPerCellQC.pdf"
    message:
        "[Quality Control] Compare low-quality cells"
    script:
        "../scripts/01-quality-control/eulerPerCellQC.R"

rule perFeatureQCMetrics:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds"
    output:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    message:
        "[Quality Control] Compute per-feature quality control metrics"
    script:
        "../scripts/01-quality-control/perFeatureQCMetrics.R"

rule plotFeatureMean:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotFeatureMean.pdf"
    message:
        "[Quality Control] Plot the mean counts for each feature"
    script:
        "../scripts/01-quality-control/plotFeatureMean.R"

rule plotFeatureDetected:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotFeatureDetected.pdf"
    message:
        "[Quality Control] Plot the percentage of observations above detection limit"
    script:
        "../scripts/01-quality-control/plotFeatureDetected.R"

rule plotMeanVsDetected:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotMeanVsDetected.pdf"
    message:
        "[Quality Control] Plot mean count against detected features"
    script:
        "../scripts/01-quality-control/plotMeanVsDetected.R"

rule plotHighestExprs:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds"
    output:
        pdf = "analysis/01-quality-control/plotHighestExprs.pdf"
    message:
        "[Quality Control] Plot the features with the highest average expression across all cells"
    script:
        "../scripts/01-quality-control/plotHighestExprs.R"

rule filterCellByQC:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds",
        csv = "analysis/01-quality-control/{output}.csv"
    output:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    message:
        "[Quality Control] Remove low-quality cells"
    script:
        "../scripts/01-quality-control/filterCellByQC.R"
