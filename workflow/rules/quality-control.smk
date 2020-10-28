# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule perCellQCMetrics:
    input:
        rds = "analysis/droplet-processing/filterByDrops.rds",
        txt = expand("resources/subsets/{subset}.txt", subset = "MT")
    output:
        rds = "analysis/quality-control/perCellQCMetrics.rds"
    log:
        out = "analysis/quality-control/perCellQCMetrics.out",
        err = "analysis/quality-control/perCellQCMetrics.err"
    message:
        "[Quality Control] Compute per-cell quality control metrics"
    script:
        "../scripts/quality-control/perCellQCMetrics.R"

rule quickPerCellQC:
    input:
        rds = "analysis/quality-control/perCellQCMetrics.rds"
    output:
        rds = "analysis/quality-control/quickPerCellQC.rds"
    params:
        sub = "MT"
    log:
        out = "analysis/quality-control/quickPerCellQC.out",
        err = "analysis/quality-control/quickPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on frequently used QC metrics"
    script:
        "../scripts/quality-control/quickPerCellQC.R"

rule plotColData_sum:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/plotColData-sum.pdf"
    log:
        out = "analysis/quality-control/plotColData-sum.out",
        err = "analysis/quality-control/plotColData-sum.err"
    message:
        "[Quality Control] Plot the sum of counts for each cell"
    script:
        "../scripts/quality-control/plotColData-sum.R"

rule plotColData_detected:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/plotColData-detected.pdf"
    log:
        out = "analysis/quality-control/plotColData-detected.out",
        err = "analysis/quality-control/plotColData-detected.err"
    message:
        "[Quality Control] Plot the number of observations above detection limit"
    script:
        "../scripts/quality-control/plotColData-detected.R"

rule plotColData_MT:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/plotColData-MT.pdf"
    log:
        out = "analysis/quality-control/plotColData-MT.out",
        err = "analysis/quality-control/plotColData-MT.err"
    message:
        "[Quality Control] Plot the number of observations above detection limit"
    script:
        "../scripts/quality-control/plotColData-MT.R"

rule plotColData_sum_detected:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/plotColData-sum-detected.pdf"
    log:
        out = "analysis/quality-control/plotColData-sum-detected.out",
        err = "analysis/quality-control/plotColData-sum-detected.err"
    message:
        "[Quality control] Plot library size against number of expressed genes"
    script:
        "../scripts/quality-control/plotColData-sum-detected.R"

rule plotColData_sum_MT:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/plotColData-sum-MT.pdf"
    log:
        out = "analysis/quality-control/plotColData-sum-MT.out",
        err = "analysis/quality-control/plotColData-sum-MT.err"
    message:
        "[Quality control] Plot library size against MT proportion"
    script:
        "../scripts/quality-control/plotColData-sum-MT.R"

rule fixedPerCellQC:
    input:
        csv = "analysis/quality-control/perCellQCMetrics.rds"
    output:
        rds = "analysis/quality-control/fixedPerCellQC.rds"
    log:
        out = "analysis/quality-control/fixedPerCellQC.out",
        err = "analysis/quality-control/fixedPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on manually defined QC metrics"
    script:
        "../scripts/quality-control/fixedPerCellQC.R"

rule adjoutPerCellQC:
    input:
        rds = "analysis/quality-control/perCellQCMetrics.rds"
    output:
        rds = "analysis/quality-control/adjoutPerCellQC.rds"
    params:
        sub = "MT"
    log:
        out = "analysis/quality-control/adjoutPerCellQC.out",
        err = "analysis/quality-control/adjoutPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on the adjusted 'outlyingness' of QC metrics"
    script:
        "../scripts/quality-control/outlyPerCellQC.R"

rule eulerPerCellQC:
    input:
        csv = expand("analysis/quality-control/{basename}.csv", basename = ["fixedPerCellQC", "quickPerCellQC", "robustPerCellQC"])
    output:
        pdf = "analysis/quality-control/eulerPerCellQC.pdf"
    log:
        out = "analysis/quality-control/eulerPerCellQC.out",
        err = "analysis/quality-control/eulerPerCellQC.err"
    message:
        "[Quality Control] Compare low-quality cells"
    script:
        "../scripts/quality-control/eulerPerCellQC.R"

rule topTagsByQC:
    input:
        rds = "analysis/01-droplet-processing/filterDrops.rds",
        csv = "analysis/quality-control/quickPerCellQC.csv"
    output:
        csv = "analysis/quality-control/topTagsByQC.csv"
    log:
        out = "analysis/quality-control/topTagsByQC.out",
        err = "analysis/quality-control/topTagsByQC.err"
    message:
        "[Quality Control] Perform DE analysis between cells which passed and failed QC"
    script:
        "../scripts/quality-control/topTagsByQC.R"

rule plotTagsByQC:
    input:
        csv = "analysis/quality-control/topTagsByQC.csv"
    output:
        pdf = "analysis/quality-control/plotTagsByQC.pdf"
    log:
        out = "analysis/quality-control/plotTagsByQC.out",
        err = "analysis/quality-control/plotTagsByQC.err"
    message:
        "[Quality Control] Create a MD plot for cells which passed and failed QC"
    script:
        "../scripts/quality-control/plotTagsByQC.R"

rule filterCellByQC:
    input:
        rds = ["analysis/01-droplet-processing/filterDrops.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        rds = "analysis/quality-control/filterCellByQC.rds"
    log:
        out = "analysis/quality-control/filterCellByQC.out",
        err = "analysis/quality-control/filterCellByQC.err"
    message:
        "[Quality Control] Filter low-quality cells"
    script:
        "../scripts/quality-control/filterCellByQC.R"

rule perFeatureQCMetrics:
    input:
        rds = "analysis/droplet-processing/filterByDrops.rds"
    output:
        rds = "analysis/quality-control/perFeatureQCMetrics.rds"
    log:
        out = "analysis/quality-control/perFeatureQCMetrics.out",
        err = "analysis/quality-control/perFeatureQCMetrics.err"
    message:
        "[Quality Control] Compute per-feature quality control metrics"
    script:
        "../scripts/quality-control/perFeatureQCMetrics.R"

rule plotFeatureMean:
    input:
        rds = "analysis/quality-control/perFeatureQCMetrics.rds"
    output:
        pdf = "analysis/quality-control/plotFeatureMean.pdf"
    log:
        out = "analysis/quality-control/plotFeatureMean.out",
        err = "analysis/quality-control/plotFeatureMean.err"
    message:
        "[Quality Control] Plot the mean counts for each feature"
    script:
        "../scripts/quality-control/plotFeatureMean.R"

rule plotFeatureDetected:
    input:
        rds = "analysis/quality-control/perFeatureQCMetrics.rds"
    output:
        pdf = "analysis/quality-control/plotFeatureDetected.pdf"
    log:
        out = "analysis/quality-control/plotFeatureDetected.out",
        err = "analysis/quality-control/plotFeatureDetected.err"
    message:
        "[Quality Control] Plot the percentage of observations above detection limit"
    script:
        "../scripts/quality-control/plotFeatureDetected.R"

rule plotFeatureMeanVsDetected:
    input:
        rds = "analysis/quality-control/perFeatureQCMetrics.rds"
    output:
        pdf = "analysis/quality-control/plotFeatureMeanVsDetected.pdf"
    log:
        out = "analysis/quality-control/plotFeatureMeanVsDetected.out",
        err = "analysis/quality-control/plotFeatureMeanVsDetected.err"
    message:
        "[Quality Control] Plot feature mean verus "
    script:
        "../scripts/quality-control/plotFeatureMeanVsDetected.R"

rule plotHighestExprs:
    input:
        rds = "analysis/droplet-processing/filterByDrops.rds"
    output:
        pdf = "analysis/quality-control/plotHighestExprs.pdf"
    params:
        n = 20
    log:
        out = "analysis/quality-control/plotHighestExprs.out",
        err = "analysis/quality-control/plotHighestExprs.err"
    message:
        "[Quality Control] Plot the highest expressing features"
    script:
        "../scripts/quality-control/plotHighestExprs.R"

# Dimensionality reduction

"""

rule runPCA:
    input:
        rds = "analysis/01-droplet-processing/filterDrops.rds"
    output:
        csv = "analysis/quality-control/runPCA.csv"
    log:
        out = "analysis/quality-control/runPCA.out",
        err = "analysis/quality-control/runPCA.err"
    message:
        "[Quality Control] Perform PCA on expression data"
    script:
        "../scripts/quality-control/runPCA.R"

rule runTSNE:
    input:
        rds = "analysis/01-droplet-processing/filterDrops.rds"
    output:
        csv = "analysis/quality-control/runTSNE.csv"
    log:
        out = "analysis/quality-control/runTSNE.out",
        err = "analysis/quality-control/runTSNE.err"
    message:
        "[Quality Control] Perform TSNE on expression data"
    script:
        "../scripts/quality-control/runTSNE.R"

rule runUMAP:
    input:
        rds = "analysis/01-droplet-processing/filterDrops.rds"
    output:
        csv = "analysis/quality-control/runUMAP.csv"
    log:
        out = "analysis/quality-control/runUMAP.out",
        err = "analysis/quality-control/runUMAP.err"
    message:
        "[Quality Control] Perform UMAP on expression data"
    script:
        "../scripts/quality-control/runUMAP.R"

rule plotPCA:
    input:
        csv = ["analysis/quality-control/runPCA.csv", "analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/quality-control/plotPCA.{metric}.pdf"
    log:
        out = "analysis/quality-control/plotPCA.{metric}.out",
        err = "analysis/quality-control/plotPCA.{metric}.err"
    message:
        "[Quality Control] Plot PCA coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/quality-control/plotPCA.R"

rule plotTSNE:
    input:
        csv = ["analysis/quality-control/runTSNE.csv", "analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/quality-control/plotTSNE.{metric}.pdf"
    log:
        out = "analysis/quality-control/plotTSNE.{metric}.out",
        err = "analysis/quality-control/plotTSNE.{metric}.err"
    message:
        "[Quality Control] Plot TSNE coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/quality-control/plotTSNE.R"

rule plotUMAP:
    input:
        csv = ["analysis/quality-control/runUMAP.csv", "analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.csv"]
    output:
        pdf = "analysis/quality-control/plotUMAP.{metric}.pdf"
    log:
        out = "analysis/quality-control/plotUMAP.{metric}.out",
        err = "analysis/quality-control/plotUMAP.{metric}.err"
    message:
        "[Quality Control] Plot UMAP coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/quality-control/plotUMAP.R"

"""