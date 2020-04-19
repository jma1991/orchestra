rule librarySizeFactors:
    input:
        rds = "analysis/quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/normalization/librarySizeFactors.rds"
    message:
        "[Normalization] Compute library size factors"
    script:
        "../scripts/normalization/librarySizeFactors.R"

rule calculateSumFactors:
    input:
        rds = "analysis/quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/normalization/calculateSumFactors.rds"
    message:
        "[Normalization] Compute size factors by deconvolution"
    script:
        "../scripts/normalization/calculateSumFactors.R"

rule computeSpikeFactors:
    input:
        rds = "analysis/quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/normalization/computeSpikeFactors.rds"
    params:
        alt = "Spikes"
    message:
        "[Normalization] Compute size factors with spike-ins"
    script:
        "../scripts/normalization/computeSpikeFactors.R"

rule logNormCounts:
    input:
        rds = ["analysis/quality-control/filterCellByQC.rds", "analysis/normalization/computeSpikeFactors.rds"]
    output:
        rds = "analysis/normalization/logNormCounts.rds"
    message:
        "[Normalization] Compute log-normalized expression values"
    script:
        "../scripts/normalization/logNormCounts.R"
