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

rule barcodeRanks1:
    input:
        csv = "analysis/01-quality-control/barcodeRanks.csv"
    output:
        pdf = "analysis/01-quality-control/barcodeRanks1.pdf"
    log:
        out = "analysis/01-quality-control/barcodeRanks1.out",
        err = "analysis/01-quality-control/barcodeRanks1.err"
    message:
        "[Quality Control] Plot barcode ranks"
    script:
        "../scripts/01-quality-control/barcodeRanks1.R"

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

rule filterDrops:
    input:
        rds = "analysis/01-quality-control/TENxPBMCData.rds",
        csv = "analysis/01-quality-control/emptyDrops.csv"
    output:
        rds = "analysis/01-quality-control/filterDrops.rds"
    log:
        out = "analysis/01-quality-control/filterDrops.out",
        err = "analysis/01-quality-control/filterDrops.err"
    message:
        "[Quality Control] Filter empty droplets"
    script:
        "../scripts/01-quality-control/filterDrops.R"

rule perCellQCMetrics:
    input:
        rds = "analysis/01-quality-control/filterDrops.rds"
    output:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    log:
        out = "analysis/01-quality-control/perCellQCMetrics.out",
        err = "analysis/01-quality-control/perCellQCMetrics.err"
    message:
        "[Quality Control] Compute per-cell quality control metrics"
    script:
        "../scripts/01-quality-control/perCellQCMetrics.R"

rule plotCellSum:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotCellSum.pdf"
    log:
        out = "analysis/01-quality-control/plotCellSum.out",
        err = "analysis/01-quality-control/plotCellSum.err"
    message:
        "[Quality Control] Plot the sum of counts for each cell"
    script:
        "../scripts/01-quality-control/plotCellSum.R"

rule perCellDetected:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotCellDetected.pdf"
    log:
        out = "analysis/01-quality-control/plotCellDetected.out",
        err = "analysis/01-quality-control/plotCellDetected.err"
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

rule manualPerCellQC:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        csv = "analysis/01-quality-control/manualPerCellQC.csv"
    log:
        out = "analysis/01-quality-control/manualPerCellQC.out",
        err = "analysis/01-quality-control/manualPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on manually defined QC metrics"
    script:
        "../scripts/01-quality-control/manualPerCellQC.R"

rule quickPerCellQC:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        csv = "analysis/01-quality-control/quickPerCellQC.csv"
    log:
        out = "analysis/01-quality-control/quickPerCellQC.out",
        err = "analysis/01-quality-control/quickPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on frequently used QC metrics"
    script:
        "../scripts/01-quality-control/quickPerCellQC.R"

rule robustPerCellQC:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        csv = "analysis/01-quality-control/robustPerCellQC.csv"
    log:
        out = "analysis/01-quality-control/robustPerCellQC.out",
        err = "analysis/01-quality-control/robustPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on outlying QC metrics"
    script:
        "../scripts/01-quality-control/robustPerCellQC.R"

rule eulerPerCellQC:
    input:
        csv = expand("analysis/01-quality-control/{basename}.csv", basename = ["manualPerCellQC", "quickPerCellQC", "robustPerCellQC"])
    output:
        pdf = "analysis/01-quality-control/eulerPerCellQC.pdf"
    log:
        out = "analysis/01-quality-control/eulerPerCellQC.out",
        err = "analysis/01-quality-control/eulerPerCellQC.err"
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
