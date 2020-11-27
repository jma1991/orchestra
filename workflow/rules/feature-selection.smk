# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule modelGeneVar:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneVar.rds"
    log:
        out = "analysis/feature-selection/modelGeneVar.out",
        err = "analysis/feature-selection/modelGeneVar.err"
    message:
        "[Feature selection] Model the per-gene variance"
    script:
        "../scripts/feature-selection/modelGeneVar.R"

rule plotGeneVar:
    input:
        rds = ["analysis/feature-selection/modelGeneVar.rds", "analysis/feature-selection/modelGeneVar.HVG.rds"]
    output:
        pdf = "analysis/feature-selection/plotGeneVar.pdf"
    params:
        n = 25
    log:
        out = "analysis/feature-selection/plotGeneVar.out",
        err = "analysis/feature-selection/plotGeneVar.err"
    message:
        "[Feature selection] Plot the per-gene variance"
    script:
        "../scripts/feature-selection/plotGeneVar.R"

rule modelGeneCV2:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneCV2.rds"
    log:
        out = "analysis/feature-selection/modelGeneCV2.out",
        err = "analysis/feature-selection/modelGeneCV2.err"
    message:
        "[Feature selection] Model the per-gene CV2"
    script:
        "../scripts/feature-selection/modelGeneCV2.R"

rule plotGeneCV2:
    input:
        rds = ["analysis/feature-selection/modelGeneCV2.rds", "analysis/feature-selection/modelGeneCV2.HVG.rds"]
    output:
        pdf = "analysis/feature-selection/plotGeneCV2.pdf"
    params:
        n = 25
    log:
        out = "analysis/feature-selection/plotGeneCV2.out",
        err = "analysis/feature-selection/plotGeneCV2.err"
    message:
        "[Feature selection] Plot the per-gene CV2"
    script:
        "../scripts/feature-selection/plotGeneCV2.R"

rule modelGeneVarByPoisson:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneVarByPoisson.rds"
    log:
        out = "analysis/feature-selection/modelGeneVarByPoisson.out",
        err = "analysis/feature-selection/modelGeneVarByPoisson.err"
    message:
        "[Feature selection] Model the per-gene variance with Poisson noise"
    script:
        "../scripts/feature-selection/modelGeneVarByPoisson.R"

rule plotGeneVarByPoisson:
    input:
        rds = ["analysis/feature-selection/modelGeneVarByPoisson.rds", "analysis/feature-selection/modelGeneVarByPoisson.HVG.rds"]
    output:
        pdf = "analysis/feature-selection/plotGeneVarByPoisson.pdf"
    params:
        n = 25
    log:
        out = "analysis/feature-selection/plotGeneVarByPoisson.out",
        err = "analysis/feature-selection/plotGeneVarByPoisson.err"
    message:
        "[Feature selection] Plot the per-gene variance with Poisson noise"
    script:
        "../scripts/feature-selection/plotGeneVarByPoisson.R"

rule getTopHVGs:
    input:
        rds = "analysis/feature-selection/{model}.rds",
        txt = expand("resources/subsets/{subset}.txt", subset = ["CC", "MT", "RP", "X", "Y"])
    output:
        rds = "analysis/feature-selection/{model}.HVG.rds"
    params:
        FDR = config["getTopHVGs"]["fdr.threshold"]
    log:
        out = "analysis/feature-selection/{model}.HVG.out",
        err = "analysis/feature-selection/{model}.HVG.err"
    message:
        "[Feature selection] Identify HVG using {wildcards.model} (fdr.threshold = {params.FDR})"
    script:
        "../scripts/feature-selection/getTopHVGs.R"

rule plotHeatmap:
    input:
        rds = ["analysis/normalization/logNormCounts.rds", "analysis/feature-selection/{model}.HVG.rds"]
    output:
        pdf = "analysis/feature-selection/plotHeatmap.{model}.HVG.pdf"
    params:
        size = 1000,
    log:
        out = "analysis/feature-selection/plotHeatmap.{model}.HVG.out",
        err = "analysis/feature-selection/plotHeatmap.{model}.HVG.err"
    script:
        "../scripts/feature-selection/plotHeatmap.R"

rule rowSubset:
    input:
        rds = ["analysis/normalization/logNormCounts.rds", "analysis/feature-selection/modelGeneVarByPoisson.HVG.rds"]
    output:
        rds = "analysis/feature-selection/rowSubset.rds"
    log:
        out = "analysis/feature-selection/rowSubset.out",
        err = "analysis/feature-selection/rowSubset.err"
    message:
        "[Feature selection] Set the row subset for highly variable genes"
    script:
        "../scripts/feature-selection/rowSubset.R"