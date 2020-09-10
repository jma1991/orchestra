# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule librarySizeFactors:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        csv = "analysis/02-normalization/librarySizeFactors.csv"
    log:
        out = "analysis/02-normalization/librarySizeFactors.out",
        err = "analysis/02-normalization/librarySizeFactors.err"
    message:
        "[Normalization] Compute library size factors"
    script:
        "../scripts/02-normalization/librarySizeFactors.R"

rule calculateSumFactors:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        csv = "analysis/02-normalization/calculateSumFactors.csv"
    log:
        out = "analysis/02-normalization/calculateSumFactors.out",
        err = "analysis/02-normalization/calculateSumFactors.err"
    message:
        "[Normalization] Compute size factors by deconvolution"
    script:
        "../scripts/02-normalization/calculateSumFactors.R"

rule computeSpikeFactors:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        csv = "analysis/02-normalization/computeSpikeFactors.csv"
    params:
        alt = "Spikes"
    message:
        "[Normalization] Compute size factors with spike-ins"
    script:
        "../scripts/02-normalization/computeSpikeFactors.R"


rule plotSizeFactors:
    input:
        csv = "analysis/02-normalization/{sizeFactor}.csv"
    output:
        pdf = "analysis/02-normalization/plotSizeFactors.{sizeFactor}.pdf"
    log:
        out = "analysis/02-normalization/plotSizeFactors.{sizeFactor}.out",
        err = "analysis/02-normalization/plotSizeFactors.{sizeFactor}.err"
    script:
        "../scripts/02-normalization/plotSizeFactors.R"

rule logNormCounts:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds",
        csv = "analysis/02-normalization/{sizeFactor}.csv"
    output:
        rds = "analysis/02-normalization/logNormCounts.rds"
    message:
        "[Normalization] Compute log-normalized expression values"
    script:
        "../scripts/02-normalization/logNormCounts.R"

rule scTransform:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        csv = "analysis/02-normalization/scTransform.csv"
    log:
        out = "analysis/02-normalization/scTransform.out",
        err = "analysis/02-normalization/scTransform.err"
    message:
        "[Normalization] Compute sctransform expression values"
    script:
        "../scripts/02-normalization/scTransform.R"