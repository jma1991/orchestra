# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

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

rule plot1:
    input:
        csv = ["analysis/01-quality-control/perCellQCMetrics.csv", "analysis/01-quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/01-quality-control/plot1.pdf"
    log:
        out = "analysis/01-quality-control/plot1.out",
        err = "analysis/01-quality-control/plot1.err"
    message:
        "[Quality Control] Compare low-quality cells"
    script:
        "../scripts/01-quality-control/plot1.R"

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

rule topTagsByQC:
    input:
        rds = "analysis/01-quality-control/filterDrops.rds",
        csv = "analysis/01-quality-control/quickPerCellQC.csv"
    output:
        csv = "analysis/01-quality-control/topTagsByQC.csv"
    log:
        out = "analysis/01-quality-control/topTagsByQC.out",
        err = "analysis/01-quality-control/topTagsByQC.err"
    message:
        "[Quality Control] Perform DE analysis between cells which passed and failed QC"
    script:
        "../scripts/01-quality-control/topTagsByQC.R"

rule plotTagsByQC:
    input:
        csv = "analysis/01-quality-control/topTagsByQC.csv"
    output:
        pdf = "analysis/01-quality-control/plotTagsByQC.pdf"
    log:
        out = "analysis/01-quality-control/plotTagsByQC.out",
        err = "analysis/01-quality-control/plotTagsByQC.err"
    message:
        "[Quality Control] Create a MD plot for cells which passed and failed QC"
    script:
        "../scripts/01-quality-control/plotTagsByQC.R"

rule filterCellByQC:
    input:
        rds = "analysis/01-quality-control/filterDrops.rds",
        csv = "analysis/01-quality-control/quickPerCellQC.csv"
    output:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    log:
        out = "analysis/01-quality-control/filterCellByQC.out",
        err = "analysis/01-quality-control/filterCellByQC.err"
    message:
        "[Quality Control] Filter low-quality cells"
    script:
        "../scripts/01-quality-control/filterCellByQC.R"

rule perFeatureQCMetrics:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    log:
        out = "analysis/01-quality-control/perFeatureQCMetrics.out",
        err = "analysis/01-quality-control/perFeatureQCMetrics.err"
    message:
        "[Quality Control] Compute per-feature quality control metrics"
    script:
        "../scripts/01-quality-control/perFeatureQCMetrics.R"

rule plotFeatureMean:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotFeatureMean.pdf"
    log:
        out = "analysis/01-quality-control/plotFeatureMean.out",
        err = "analysis/01-quality-control/plotFeatureMean.err"
    message:
        "[Quality Control] Plot the mean counts for each feature"
    script:
        "../scripts/01-quality-control/plotFeatureMean.R"

rule plotFeatureDetected:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotFeatureDetected.pdf"
    log:
        out = "analysis/01-quality-control/plotFeatureDetected.out",
        err = "analysis/01-quality-control/plotFeatureDetected.err"
    message:
        "[Quality Control] Plot the percentage of observations above detection limit"
    script:
        "../scripts/01-quality-control/plotFeatureDetected.R"

rule plotFeatureExprs:
    input:
        csv = "analysis/01-quality-control/perFeatureQCMetrics.csv"
    output:
        pdf = "analysis/01-quality-control/plotFeatureExprs.pdf"
    log:
        out = "analysis/01-quality-control/plotFeatureExprs.out",
        err = "analysis/01-quality-control/plotFeatureExprs.err"
    message:
        "[Quality Control] Plot the percentage of observations above detection limit against the mean counts for each feature"
    script:
        "../scripts/01-quality-control/plotFeatureExprs.R"

rule plotHighestExprs:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        pdf = "analysis/01-quality-control/plotHighestExprs.pdf"
    log:
        out = "analysis/01-quality-control/plotHighestExprs.out",
        err = "analysis/01-quality-control/plotHighestExprs.err"
    message:
        "[Quality Control] Plot the features with the highest average expression across all cells"
    script:
        "../scripts/01-quality-control/plotHighestExprs.R"

rule plotQC:
    input:
        csv = ["analysis/01-quality-control/perCellQCMetrics.csv", "analysis/01-quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/01-quality-control/plotQC.{metric}.pdf"
    log:
        out = "analysis/01-quality-control/plotQC.{metric}.out",
        err = "analysis/01-quality-control/plotQC.{metric}.err"
    script:
        "../scripts/01-quality-control/plotQC.R"

# Dimensionality reduction

rule runPCA:
    input:
        rds = "analysis/01-quality-control/filterDrops.rds"
    output:
        csv = "analysis/01-quality-control/runPCA.csv"
    log:
        out = "analysis/01-quality-control/runPCA.out",
        err = "analysis/01-quality-control/runPCA.err"
    message:
        "[Quality Control] Perform PCA on expression data"
    script:
        "../scripts/01-quality-control/runPCA.R"

rule runTSNE:
    input:
        rds = "analysis/01-quality-control/filterDrops.rds"
    output:
        csv = "analysis/01-quality-control/runTSNE.csv"
    log:
        out = "analysis/01-quality-control/runTSNE.out",
        err = "analysis/01-quality-control/runTSNE.err"
    message:
        "[Quality Control] Perform TSNE on expression data"
    script:
        "../scripts/01-quality-control/runTSNE.R"

rule runUMAP:
    input:
        rds = "analysis/01-quality-control/filterDrops.rds"
    output:
        csv = "analysis/01-quality-control/runUMAP.csv"
    log:
        out = "analysis/01-quality-control/runUMAP.out",
        err = "analysis/01-quality-control/runUMAP.err"
    message:
        "[Quality Control] Perform UMAP on expression data"
    script:
        "../scripts/01-quality-control/runUMAP.R"

rule plotPCA:
    input:
        csv = ["analysis/01-quality-control/runPCA.csv", "analysis/01-quality-control/perCellQCMetrics.csv", "analysis/01-quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/01-quality-control/plotPCA.{metric}.pdf"
    log:
        out = "analysis/01-quality-control/plotPCA.{metric}.out",
        err = "analysis/01-quality-control/plotPCA.{metric}.err"
    message:
        "[Quality Control] Plot PCA coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/01-quality-control/plotPCA.R"

rule plotTSNE:
    input:
        csv = ["analysis/01-quality-control/runTSNE.csv", "analysis/01-quality-control/perCellQCMetrics.csv", "analysis/01-quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/01-quality-control/plotTSNE.{metric}.pdf"
    log:
        out = "analysis/01-quality-control/plotTSNE.{metric}.out",
        err = "analysis/01-quality-control/plotTSNE.{metric}.err"
    message:
        "[Quality Control] Plot TSNE coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/01-quality-control/plotTSNE.R"

rule plotUMAP:
    input:
        csv = ["analysis/01-quality-control/runUMAP.csv", "analysis/01-quality-control/perCellQCMetrics.csv", "analysis/01-quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/01-quality-control/plotUMAP.{metric}.pdf"
    log:
        out = "analysis/01-quality-control/plotUMAP.{metric}.out",
        err = "analysis/01-quality-control/plotUMAP.{metric}.err"
    message:
        "[Quality Control] Plot UMAP coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/01-quality-control/plotUMAP.R"

rule report:
    output:
        html = "analysis/01-quality-control/qc.html"
    message:
        "[Quality Control] Compile the quality control report"
    script:
        "../reports/qc.Rmd"