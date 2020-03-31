rule modelGeneCV2:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "modelGeneCV2.rds"
    message:
        "Model the per-gene CV2"
    script:
        "modelGeneCV2.R"

rule modelGeneCV2WithSpikes:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "modelGeneCV2WithSpikes.rds"
    params:
        alt = "ERCC"
    message:
        "Model the per-gene CV2 with spike-ins"
    script:
        "modelGeneCV2WithSpikes.R"

rule modelGeneVar:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "modelGeneVar.rds"
    message:
        "Model the per-gene variance"
    script:
        "modelGeneVar.R"

rule modelGeneVarByPoisson:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "modelGeneVarByPoisson.rds"
    message:
        "Model the per-gene variance with Poisson noise"
    script:
        "modelGeneVarByPoisson.R"

rule modelGeneVarWithSpikes:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "modelGeneVarWithSpikes.rds"
    params:
        alt = "ERCC"
    message:
        "Model the per-gene variance with spike-ins"
    script:
        "modelGeneVarWithSpikes.R"

rule plotGeneCV2:
    input:
        rds = "modelGeneCV2.rds"
    output:
        pdf = "plotGeneCV2.pdf"
    message:
        "Plot the per-gene CV2"
    script:
        "plotGeneCV2.R"

rule plotGeneCV2WithSpikes:
    input:
        rds = "modelGeneCV2WithSpikes.rds"
    output:
        pdf = "plotGeneCV2WithSpikes.pdf"
    params:
        alt = "ERCC"
    message:
        "Plot the per-gene CV2 with spike-ins"
    script:
        "plotGeneCV2WithSpikes.R"

rule plotGeneVar:
    input:
        rds = "modelGeneVar.rds"
    output:
        pdf = "plotGeneVar.pdf"
    message:
        "Plot the per-gene variance"
    script:
        "plotGeneVar.R"

rule plotGeneVarByPoisson:
    input:
        rds = "modelGeneVarByPoisson.rds"
    output:
        pdf = "plotGeneVarByPoisson.pdf"
    message:
        "Plot the per-gene variance with Poisson noise"
    script:
        "plotGeneVarByPoisson.R"

rule plotGeneVarWithSpikes:
    input:
        rds = "modelGeneVarWithSpikes.rds"
    output:
        pdf = "plotGeneVarWithSpikes.pdf"
    params:
        alt = "ERCC"
    message:
        "Plot the per-gene variance with spike-ins"
    script:
        "plotGeneVarWithSpikes.R"

rule getTopHVGsByFDR:
    input:
        rds = "{modelGene}.rds"
    output:
        rds = "{modelGene}-getTopHVGsByFDR.rds"
    params:
        fdr = 0.05
    message:
        "Identify HVGs by FDR threshold"
    script:
        "getTopHVGsByFDR.R"

rule getTopHVGsByNumber:
    input:
        rds = "{modelGene}.rds"
    output:
        rds = "{modelGene}-getTopHVGsByNumber.rds"
    params:
        num = 2000
    message:
        "Identify HVGs by number of genes"
    script:
        "getTopHVGsByNumber.R"

rule getTopHVGsByProp:
    input:
        rds = "{modelGene}.rds"
    output:
        rds = "{modelGene}-getTopHVGsByProp.rds"
    params:
        pro = 0.1
    message:
        "Identify HVGs by proportion of genes"
    script:
        "getTopHVGsByProp.R"

rule getTopHVGsByVar:
    input:
        rds = "{modelGene}.rds"
    output:
        rds = "{modelGene}-getTopHVGsByVar.rds"
    params:
        var = 0
    message:
        "Identify HVGs by metric of variation"
    script:
        "getTopHVGsByVar.R"

rule getTopHVGs:
    input:
        rds = ["logNormCounts.rds", "modelGeneVarWithSpikes-numTopHVGs.rds"]
    output:
        rds = "getTopHVGs.rds"
    script:
        "setTopHVGs.R"
