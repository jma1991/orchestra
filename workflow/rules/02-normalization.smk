rule librarySizeFactors:
    input:
        rds = "filterCellByQC.rds"
    output:
        rds = "librarySizeFactors.rds"
    message:
        "[Normalization] Compute library size factors"
    script:
        "librarySizeFactors.R"

rule calculateSumFactors:
    input:
        rds = "filterCellByQC.rds"
    output:
        rds = "calculateSumFactors.rds"
    message:
        "[Normalization] Compute size factors by deconvolution"
    script:
        "calculateSumFactors.R"

rule computeSpikeFactors:
    input:
        rds = "filterCellByQC.rds"
    output:
        rds = "computeSpikeFactors.rds"
    params:
        alt = "ERCC"
    message:
        "[Normalization] Compute size factors with spike-ins"
    script:
        "computeSpikeFactors.R"

rule logNormCounts:
    input:
        rds = ["filterCellByQC.rds", "computeSpikeFactors.rds"]
    output:
        rds = "logNormCounts.rds"
    params:
        dwn = False
    message:
        "[Normalization] Compute log-normalized expression values"
    script:
        "logNormCounts.R"
