# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule mockSCE:
    output:
        rds = "analysis/01-quality-control/mockSCE.rds"
    message:
        "[Quality Control] Mock up a SingleCellExperiment object"
    script:
        "../scripts/01-quality-control/mockSCE.R"

rule perCellQCMetrics:
    input:
        rds = "analysis/01-quality-control/mockSCE.rds"
    output:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
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
        "[Quality Control] Plot the sum of features for each cell"
    script:
        "../scripts/01-quality-control/plotCellDetected.R"

rule plotSubset:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotSubset.{sub}.pdf"
    message:
        "[Quality Control] Plot the percentage of cells detected: {wildcards.sub}"
    script:
        "../scripts/01-quality-control/plotSubset.R"

rule plotAltExp:
    input:
        csv = "analysis/01-quality-control/perCellQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotAltExp.{alt}.pdf"
    message:
        "[Quality Control] Plot the percentage of cells detected: {wildcards.alt}"
    script:
        "../scripts/01-quality-control/plotAltExp.R"

rule plotColData:
    input:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    output:
        pdf = "analysis/01-quality-control/plotColData-{params.alt}-vs-{params.sub}.pdf"
    params:
        alt = "ERCC",
        sub = "MT"
    message:
        "[Quality Control] Plot proportion of {params.alt} against {params.sub}"
    script:
        "plotColData.R"

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
        alt = "Spikes"
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
        alt = "Spikes"
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
        rds = "analysis/01-quality-control/mockSCE.rds"
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
        "[Quality Control] Plot the mean count for each feature"
    script:
        "../scripts/01-quality-control/plotFeatureMean.R"

rule plotFeatureDetected:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotFeatureDetected.pdf"
    message:
        "[Quality Control] Plot the percentage of detected features"
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
        rds = "analysis/01-quality-control/mockSCE.rds"
    output:
        pdf = "analysis/01-quality-control/plotHighestExprs.pdf"
    message:
        "[Quality Control] Plot the highest expressing features"
    script:
        "../scripts/01-quality-control/plotHighestExprs.R"

rule filterCellByQC:
    input:
        rds = "analysis/01-quality-control/mockSCE.rds",
        csv = "analysis/01-quality-control/quickPerCellQC.csv"
    output:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    message:
        "[Quality Control] Remove low-quality cells"
    script:
        "../scripts/01-quality-control/filterCellByQC.R"
