# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule librarySizeFactors:
    input:
        rds = "analysis/02-quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/03-normalization/librarySizeFactors.rds"
    log:
        out = "analysis/03-normalization/librarySizeFactors.out",
        err = "analysis/03-normalization/librarySizeFactors.err"
    message:
        "[Normalization] Compute library size factors"
    script:
        "../scripts/03-normalization/librarySizeFactors.R"

rule calculateSumFactors:
    input:
        rds = "analysis/02-quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/03-normalization/calculateSumFactors.rds"
    log:
        out = "analysis/03-normalization/calculateSumFactors.out",
        err = "analysis/03-normalization/calculateSumFactors.err"
    message:
        "[Normalization] Compute size factors by deconvolution"
    script:
        "../scripts/03-normalization/calculateSumFactors.R"

rule computeSpikeFactors:
    input:
        rds = "analysis/02-quality-control/filterCellByQC.rds"
    output:
        csv = "analysis/03-normalization/computeSpikeFactors.csv"
    params:
        alt = "Spikes"
    message:
        "[Normalization] Compute size factors with spike-ins"
    script:
        "../scripts/03-normalization/computeSpikeFactors.R"

rule plotSizeFactors:
    input:
        csv = "analysis/03-normalization/{sizeFactor}.csv"
    output:
        pdf = "analysis/03-normalization/plotSizeFactors.{sizeFactor}.pdf"
    log:
        out = "analysis/03-normalization/plotSizeFactors.{sizeFactor}.out",
        err = "analysis/03-normalization/plotSizeFactors.{sizeFactor}.err"
    script:
        "../scripts/03-normalization/plotSizeFactors.R"

rule logNormCounts:
    input:
        rds = ["analysis/02-quality-control/filterCellByQC.rds", "analysis/03-normalization/calculateSumFactors.rds"]
    output:
        rds = "analysis/03-normalization/logNormCounts.rds"
    log:
        out = "analysis/03-normalization/logNormCounts.out",
        err = "analysis/03-normalization/logNormCounts.err"
    message:
        "[Normalization] Compute log-normalized expression values"
    script:
        "../scripts/03-normalization/logNormCounts.R"