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
        rds = "analysis/feature-selection/modelGeneVar.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneVar.pdf"
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
        rds = "analysis/feature-selection/modelGeneCV2.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneCV2.pdf"
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
        rds = "analysis/feature-selection/modelGeneVarByPoisson.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneVarByPoisson.pdf"
    log:
        out = "analysis/feature-selection/plotGeneVarByPoisson.out",
        err = "analysis/feature-selection/plotGeneVarByPoisson.err"
    message:
        "[Feature selection] Plot the per-gene variance with Poisson noise"
    script:
        "../scripts/feature-selection/plotGeneVarByPoisson.R"

rule getTopHVGs:
    input:
        rds = "analysis/feature-selection/{model}.rds"
    output:
        rds = "analysis/feature-selection/{model}.HVGs.rds"
    params:
        FDR = 0.05
    log:
        out = "analysis/feature-selection/{model}.HVGs.out",
        err = "analysis/feature-selection/{model}.HVGs.err"
    message:
        "[Feature selection] Define a set of highly variable genes, based on variance modelling statistics from {wildcards.model}"
    script:
        "../scripts/feature-selection/getTopHVGs.R"

rule rowSubset:
    input:
        rds = ["analysis/normalization/logNormCounts.rds", "analysis/feature-selection/modelGeneVar.HVGs.rds"]
    output:
        rds = "analysis/feature-selection/rowSubset.rds"
    log:
        out = "analysis/feature-selection/rowSubset.out",
        err = "analysis/feature-selection/rowSubset.err"
    message:
        "[Feature selection] Set the row subset for highly variable genes"
    script:
        "../scripts/feature-selection/rowSubset.R"