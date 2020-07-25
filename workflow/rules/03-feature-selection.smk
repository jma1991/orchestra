# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule modelGeneVar:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneVar.csv"
    message:
        "[Feature selection] Model the per-gene variance"
    script:
        "../scripts/03-feature-selection/modelGeneVar.R"

rule plotGeneVar:
    input:
        csv = "analysis/03-feature-selection/modelGeneVar.csv"
    output:
        pdf = "analysis/03-feature-selection/plotGeneVar.pdf"
    message:
        "[Feature selection] Plot the per-gene variance"
    script:
        "../scripts/03-feature-selection/plotGeneVar.R"

rule modelGeneCV2:
    input:
        rds = "analysis/02-normalization/logNormCounts.rds"
    output:
        csv = "analysis/03-feature-selection/modelGeneCV2.csv"
    message:
        "[Feature selection] Model the per-gene CV2"
    script:
        "../scripts/03-feature-selection/modelGeneCV2.R"

rule plotGeneCV2:
    input:
        csv = "analysis/03-feature-selection/modelGeneCV2.csv"
    output:
        pdf = "analysis/03-feature-selection/plotGeneCV2.pdf"
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
    message:
        "[Feature selection] Model the per-gene variance with Poisson noise"
    script:
        "../scripts/03-feature-selection/modelGeneVarByPoisson.R"

rule plotGeneVarByPoisson:
    input:
        rds = "analysis/03-feature-selection/modelGeneVarByPoisson.rds"
    output:
        pdf = "analysis/03-feature-selection/plotGeneVarByPoisson.pdf"
    message:
        "[Feature selection] Plot the per-gene variance with Poisson noise"
    script:
        "../scripts/03-feature-selection/plotGeneVarByPoisson.R"

###

rule getTopHVGsByFDR:
    input:
        rds = "analysis/03-feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/03-feature-selection/{modelGene}-getTopHVGsByFDR.rds"
    params:
        fdr = 0.05
    message:
        "[Feature selection] Identify HVGs by FDR threshold using {wildcards.modelGene}"
    script:
        "../scripts/03-feature-selection/getTopHVGsByFDR.R"

rule getTopHVGsByNumber:
    input:
        rds = "analysis/03-feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/03-feature-selection/{modelGene}-getTopHVGsByNumber.rds"
    params:
        num = 2000
    message:
        "[Feature selection] Identify HVGs by number of genes"
    script:
        "../scripts/03-feature-selection/getTopHVGsByNumber.R"

rule getTopHVGsByProp:
    input:
        rds = "analysis/03-feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/03-feature-selection/{modelGene}-getTopHVGsByProp.rds"
    params:
        pro = 0.1
    message:
        "[Feature selection] Identify HVGs by proportion of genes"
    script:
        "../scripts/03-feature-selection/getTopHVGsByProp.R"

rule getTopHVGsByVar:
    input:
        rds = "analysis/03-feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/03-feature-selection/{modelGene}-getTopHVGsByVar.rds"
    params:
        var = 0
    message:
        "[Feature selection] Identify HVGs by metric of variation"
    script:
        "../scripts/03-feature-selection/getTopHVGsByVar.R"

rule setTopHVGs:
    input:
        rds = ["analysis/02-normalization/logNormCounts.rds",
               "analysis/03-feature-selection/modelGeneVarWithSpikes.rds",
               "analysis/03-feature-selection/modelGeneVarWithSpikes-getTopHVGsByNumber.rds"]
    output:
        rds = "analysis/03-feature-selection/setTopHVGs.rds"
    message:
        "[Feature selection] Select HVGs"
    script:
        "../scripts/03-feature-selection/setTopHVGs.R"
