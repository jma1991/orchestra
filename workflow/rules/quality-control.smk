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
        subsets = "MT",
        nmads = config["quickPerCellQC"]["nmads"]
    log:
        out = "analysis/quality-control/quickPerCellQC.out",
        err = "analysis/quality-control/quickPerCellQC.err"
    message:
        "[Quality Control] Identify low-quality cells based on frequently used QC metrics"
    script:
        "../scripts/quality-control/quickPerCellQC.R"

rule perCellQCMetrics_sum:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/perCellQCMetrics.sum.pdf"
    log:
        out = "analysis/quality-control/perCellQCMetrics.sum.out",
        err = "analysis/quality-control/perCellQCMetrics.sum.err"
    message:
        "[Quality Control] Plot the sum of counts for each cell"
    script:
        "../scripts/quality-control/perCellQCMetrics.sum.R"

rule perCellQCMetrics_detected:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/perCellQCMetrics.detected.pdf"
    log:
        out = "analysis/quality-control/perCellQCMetrics.detected.out",
        err = "analysis/quality-control/plotperCellQCMetricsColData.detected.err"
    message:
        "[Quality Control] Plot the number of observations above detection limit"
    script:
        "../scripts/quality-control/perCellQCMetrics.detected.R"

rule perCellQCMetrics_subsets_MT_percent:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/perCellQCMetrics.subsets_MT_percent.pdf"
    log:
        out = "analysis/quality-control/perCellQCMetrics.subsets_MT_percent.out",
        err = "analysis/quality-control/perCellQCMetrics.subsets_MT_percent.err"
    message:
        "[Quality Control] Plot the proportion of mitochondrial counts"
    script:
        "../scripts/quality-control/perCellQCMetrics.subsets_MT_percent.R"

rule perCellQCMetrics_sum_subsets_MT_percent:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/perCellQCMetrics.sum.subsets_MT_percent.pdf"
    log:
        out = "analysis/quality-control/perCellQCMetrics.sum.subsets_MT_percent.out",
        err = "analysis/quality-control/perCellQCMetrics.sum.subsets_MT_percent.err"
    message:
        "[Quality Control] Plot the sum of counts for each cell against the proportion of mitochondrial counts"
    script:
        "../scripts/quality-control/perCellQCMetrics.sum.subsets_MT_percent.R"

rule perCellQCMetrics_sum_detected:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        pdf = "analysis/quality-control/perCellQCMetrics.sum.detected.pdf"
    log:
        out = "analysis/quality-control/perCellQCMetrics.sum.detected.out",
        err = "analysis/quality-control/perCellQCMetrics.sum.detected.err"
    message:
        "[Quality Control] Plot the sum of counts for each cell against the number of observations above detection limit"
    script:
        "../scripts/quality-control/perCellQCMetrics.sum.detected.R"

rule filterCellsByQC:
    input:
        rds = ["analysis/droplet-processing/filterByDrops.rds", "analysis/quality-control/quickPerCellQC.rds"]
    output:
        rds = "analysis/quality-control/filterCellsByQC.rds"
    log:
        out = "analysis/quality-control/filterCellsByQC.out",
        err = "analysis/quality-control/filterCellsByQC.err"
    message:
        "[Quality Control] Filter low-quality cells"
    script:
        "../scripts/quality-control/filterCellsByQC.R"

rule perFeatureQCMetrics:
    input:
        rds = "analysis/quality-control/filterCellsByQC.rds"
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

rule plotExprsFreqVsMean:
    input:
        rds = "analysis/quality-control/perFeatureQCMetrics.rds"
    output:
        pdf = "analysis/quality-control/plotExprsFreqVsMean.pdf"
    params:
        n = 25
    log:
        out = "analysis/quality-control/plotExprsFreqVsMean.out",
        err = "analysis/quality-control/plotExprsFreqVsMean.err"
    message:
        "[Quality Control] Plot frequency of expression against mean expression level"
    script:
        "../scripts/quality-control/plotExprsFreqVsMean.R"

rule plotHighestExprs:
    input:
        rds = "analysis/quality-control/filterCellsByQC.rds"
    output:
        pdf = "analysis/quality-control/plotHighestExprs.pdf"
    params:
        n = 25
    log:
        out = "analysis/quality-control/plotHighestExprs.out",
        err = "analysis/quality-control/plotHighestExprs.err"
    message:
        "[Quality Control] Plot the highest expressing features"
    script:
        "../scripts/quality-control/plotHighestExprs.R"

rule calculatePCA:
    input:
        rds = "analysis/quality-control/filterCellsByQC.rds"
    output:
        rds = "analysis/quality-control/calculatePCA.rds"
    log:
        out = "analysis/quality-control/calculatePCA.out",
        err = "analysis/quality-control/calculatePCA.err"
    message:
        "[Quality Control] Perform PCA on expression data"
    script:
        "../scripts/quality-control/calculatePCA.R"

rule calculateTSNE:
    input:
        rds = "analysis/quality-control/calculatePCA.rds"
    output:
        rds = "analysis/quality-control/calculateTSNE.rds"
    log:
        out = "analysis/quality-control/calculateTSNE.out",
        err = "analysis/quality-control/calculateTSNE.err"
    message:
        "[Quality Control] Perform TSNE on expression data"
    script:
        "../scripts/quality-control/calculateTSNE.R"

rule calculateUMAP:
    input:
        rds = "analysis/quality-control/calculatePCA.rds"
    output:
        rds = "analysis/quality-control/calculateUMAP.rds"
    log:
        out = "analysis/quality-control/calculateUMAP.out",
        err = "analysis/quality-control/calculateUMAP.err"
    message:
        "[Quality Control] Perform UMAP on expression data"
    script:
        "../scripts/quality-control/calculateUMAP.R"

rule plotPCA:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/calculatePCA.rds"]
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
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/calculateTSNE.rds"]
    output:
        pdf = "analysis/quality-control/plotTSNE.{metric}.pdf"
    params:
        var = "{metric}"
    log:
        out = "analysis/quality-control/plotTSNE.{metric}.out",
        err = "analysis/quality-control/plotTSNE.{metric}.err"
    message:
        "[Quality Control] Plot TSNE coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/quality-control/plotTSNE.R"

rule plotUMAP:
    input:
        rds = ["analysis/quality-control/perCellQCMetrics.rds", "analysis/quality-control/calculateUMAP.rds"]
    output:
        pdf = "analysis/quality-control/plotUMAP.{metric}.pdf"
    params:
        var = "{metric}"
    log:
        out = "analysis/quality-control/plotUMAP.{metric}.out",
        err = "analysis/quality-control/plotUMAP.{metric}.err"
    message:
        "[Quality Control] Plot UMAP coloured by QC metric: {wildcards.metric}"
    script:
        "../scripts/quality-control/plotUMAP.R"