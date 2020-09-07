# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule TENxPBMCData:
    output:
        rds = "analysis/01-quality-control/TENxPBMCData.rds"
    message:
        "[Quality Control] Download PBMC SingleCellExperiment object"
    script:
        "../scripts/01-quality-control/TENxPBMCData.R"

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
