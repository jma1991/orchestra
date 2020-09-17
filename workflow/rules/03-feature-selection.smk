# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule modelGeneVar:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneVar.csv"
    log:
        out = "analysis/03-feature-selection/modelGeneVar.out",
        err = "analysis/03-feature-selection/modelGeneVar.err"
    message:
        "[Feature selection] Model the per-gene variance"
    script:
        "../scripts/03-feature-selection/modelGeneVar.R"

rule plotGeneVar:
    input:
        csv = "analysis/03-feature-selection/modelGeneVar.csv"
    output:
        pdf = "analysis/03-feature-selection/plotGeneVar.pdf"
    log:
        out = "analysis/03-feature-selection/plotGeneVar.out",
        err = "analysis/03-feature-selection/plotGeneVar.err"
    message:
        "[Feature selection] Plot the per-gene variance"
    script:
        "../scripts/03-feature-selection/plotGeneVar.R"

rule modelGeneCV2:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneCV2.csv"
    log:
        out = "analysis/03-feature-selection/modelGeneCV2.out",
        err = "analysis/03-feature-selection/modelGeneCV2.err"
    message:
        "[Feature selection] Model the per-gene CV2"
    script:
        "../scripts/03-feature-selection/modelGeneCV2.R"

rule plotGeneCV2:
    input:
        csv = "analysis/03-feature-selection/modelGeneCV2.csv"
    output:
        pdf = "analysis/03-feature-selection/plotGeneCV2.pdf"
    log:
        out = "analysis/03-feature-selection/plotGeneCV2.out",
        err = "analysis/03-feature-selection/plotGeneCV2.err"
    message:
        "[Feature selection] Plot the per-gene CV2"
    script:
        "../scripts/03-feature-selection/plotGeneCV2.R"

rule modelGeneVarWithSpikes:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneVarWithSpikes.csv"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Model the per-gene variance with spike-ins"
    script:
        "../scripts/03-feature-selection/modelGeneVarWithSpikes.R"

rule plotGeneVarWithSpikes:
    input:
        csv = "analysis/03-feature-selection/modelGeneVarWithSpikes.csv"
    output:
        pdf = "analysis/03-feature-selection/plotGeneVarWithSpikes.pdf"
    message:
        "[Feature selection] Plot the per-gene variance with spike-ins"
    script:
        "../scripts/03-feature-selection/plotGeneVarWithSpikes.R"

rule modelGeneCV2WithSpikes:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneCV2WithSpikes.csv"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Model the per-gene CV2 with spike-ins"
    script:
        "../scripts/03-feature-selection/modelGeneCV2WithSpikes.R"

rule plotGeneCV2WithSpikes:
    input:
        rds = "analysis/03-feature-selection/modelGeneCV2WithSpikes.rds"
    output:
        pdf = "analysis/03-feature-selection/plotGeneCV2WithSpikes.pdf"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Plot the per-gene CV2 with spike-ins"
    script:
        "../scripts/03-feature-selection/plotGeneCV2WithSpikes.R"

rule modelGeneVarByPoisson:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneVarByPoisson.csv"
    log:
        out = "analysis/03-feature-selection/modelGeneVarByPoisson.out",
        err = "analysis/03-feature-selection/modelGeneVarByPoisson.err"
    message:
        "[Feature selection] Model the per-gene variance with Poisson noise"
    script:
        "../scripts/03-feature-selection/modelGeneVarByPoisson.R"

rule plotGeneVarByPoisson:
    input:
        csv = "analysis/03-feature-selection/modelGeneVarByPoisson.csv"
    output:
        pdf = "analysis/03-feature-selection/plotGeneVarByPoisson.pdf"
    log:
        out = "analysis/03-feature-selection/plotGeneVarByPoisson.out",
        err = "analysis/03-feature-selection/plotGeneVarByPoisson.err"
    message:
        "[Feature selection] Plot the per-gene variance with Poisson noise"
    script:
        "../scripts/03-feature-selection/plotGeneVarByPoisson.R"

rule getTopHVGs:
    input:
        csv = "analysis/03-feature-selection/{modelGene}.csv"
    output:
        txt = "analysis/03-feature-selection/{modelGene}.getTopHVGs.txt"
    log:
        out = "analysis/03-feature-selection/{modelGene}.getTopHVGs.out",
        err = "analysis/03-feature-selection/{modelGene}.getTopHVGs.err"
    message:
        "[Feature selection] Define a set of highly variable genes"
    script:
        "../scripts/03-feature-selection/getTopHVGs.R"

rule VariableFeaturePlot:
    input:
        csv = "analysis/03-feature-selection/{modelGene}.csv",
        txt = "analysis/03-feature-selection/{modelGene}.getTopHVGs.txt"
    output:
        pdf = "analysis/03-feature-selection/{modelGene}.getTopHVGs.VariableFeaturePlot.pdf"
    log:
        out = "analysis/03-feature-selection/{modelGene}.getTopHVGs.VariableFeaturePlot.out",
        err = "analysis/03-feature-selection/{modelGene}.getTopHVGs.VariableFeaturePlot.err"
    message:
        "[Feature selection] Plot variable features"
    script:
        "../scripts/03-feature-selection/VariableFeaturePlot.R"

rule VariableFeatureHeatmap:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds",
        txt = "analysis/03-feature-selection/{modelGene}.getTopHVGsByFDR.txt"
    output:
        pdf = "analysis/03-feature-selection/{modelGene}.getTopHVGsByFDR.VariableFeatureHeatmap.pdf"
    message:
        "[Feature selection] Plot heatmap of variable features"
    script:
        "../scripts/03-feature-selection/VariableFeatureHeatmap.R"

rule setTopHVGs:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds",
        txt = "analysis/03-feature-selection/modelGeneVar.getTopHVGsByFDR.txt"
    output:
        rds = "analysis/03-feature-selection/setTopHVGs.rds"
    message:
        "[Feature selection] Define a set of highly variable genes"
    script:
        "../scripts/03-feature-selection/setTopHVGs.R"
