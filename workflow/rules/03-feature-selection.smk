rule modelGeneVar:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneVar.rds"
    message:
        "[Feature selection] Model the per-gene variance"
    script:
        "../scripts/feature-selection/modelGeneVar.R"

rule plotGeneVar:
    input:
        rds = "analysis/feature-selection/modelGeneVar.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneVar.pdf"
    message:
        "[Feature selection] Plot the per-gene variance"
    script:
        "../scripts/feature-selection/plotGeneVar.R"

rule modelGeneCV2:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneCV2.rds"
    message:
        "[Feature selection] Model the per-gene CV2"
    script:
        "../scripts/feature-selection/modelGeneCV2.R"

rule plotGeneCV2:
    input:
        rds = "analysis/feature-selection/modelGeneCV2.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneCV2.pdf"
    message:
        "[Feature selection] Plot the per-gene CV2"
    script:
        "../scripts/feature-selection/plotGeneCV2.R"

rule modelGeneVarWithSpikes:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneVarWithSpikes.rds"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Model the per-gene variance with spike-ins"
    script:
        "../scripts/feature-selection/modelGeneVarWithSpikes.R"

rule plotGeneVarWithSpikes:
    input:
        rds = "analysis/feature-selection/modelGeneVarWithSpikes.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneVarWithSpikes.pdf"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Plot the per-gene variance with spike-ins"
    script:
        "../scripts/feature-selection/plotGeneVarWithSpikes.R"

rule modelGeneCV2WithSpikes:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneCV2WithSpikes.rds"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Model the per-gene CV2 with spike-ins"
    script:
        "../scripts/feature-selection/modelGeneCV2WithSpikes.R"

rule plotGeneCV2WithSpikes:
    input:
        rds = "analysis/feature-selection/modelGeneCV2WithSpikes.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneCV2WithSpikes.pdf"
    params:
        alt = "Spikes"
    message:
        "[Feature selection] Plot the per-gene CV2 with spike-ins"
    script:
        "../scripts/feature-selection/plotGeneCV2WithSpikes.R"

rule modelGeneVarByPoisson:
    input:
        rds = "analysis/normalization/logNormCounts.rds"
    output:
        rds = "analysis/feature-selection/modelGeneVarByPoisson.rds"
    message:
        "[Feature selection] Model the per-gene variance with Poisson noise"
    script:
        "../scripts/feature-selection/modelGeneVarByPoisson.R"

rule plotGeneVarByPoisson:
    input:
        rds = "analysis/feature-selection/modelGeneVarByPoisson.rds"
    output:
        pdf = "analysis/feature-selection/plotGeneVarByPoisson.pdf"
    message:
        "[Feature selection] Plot the per-gene variance with Poisson noise"
    script:
        "../scripts/feature-selection/plotGeneVarByPoisson.R"

###

rule getTopHVGsByFDR:
    input:
        rds = "analysis/feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/feature-selection/{modelGene}-getTopHVGsByFDR.rds"
    params:
        fdr = 0.05
    message:
        "[Feature selection] Identify HVGs by FDR threshold using {wildcards.modelGene}"
    script:
        "../scripts/feature-selection/getTopHVGsByFDR.R"

rule getTopHVGsByNumber:
    input:
        rds = "analysis/feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/feature-selection/{modelGene}-getTopHVGsByNumber.rds"
    params:
        num = 2000
    message:
        "[Feature selection] Identify HVGs by number of genes"
    script:
        "../scripts/feature-selection/getTopHVGsByNumber.R"

rule getTopHVGsByProp:
    input:
        rds = "analysis/feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/feature-selection/{modelGene}-getTopHVGsByProp.rds"
    params:
        pro = 0.1
    message:
        "[Feature selection] Identify HVGs by proportion of genes"
    script:
        "../scripts/feature-selection/getTopHVGsByProp.R"

rule getTopHVGsByVar:
    input:
        rds = "analysis/feature-selection/{modelGene}.rds"
    output:
        rds = "analysis/feature-selection/{modelGene}-getTopHVGsByVar.rds"
    params:
        var = 0
    message:
        "[Feature selection] Identify HVGs by metric of variation"
    script:
        "../scripts/feature-selection/getTopHVGsByVar.R"

rule setTopHVGs:
    input:
        rds = ["analysis/normalization/logNormCounts.rds",
               "analysis/feature-selection/modelGeneVarWithSpikes.rds",
               "analysis/feature-selection/modelGeneVarWithSpikes-getTopHVGsByNumber.rds"]
    output:
        rds = "analysis/feature-selection/setTopHVGs.rds"
    message:
        "[Feature selection] Select HVGs"
    script:
        "../scripts/feature-selection/setTopHVGs.R"
