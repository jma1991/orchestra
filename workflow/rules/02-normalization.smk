rule librarySizeFactors:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/02-normalization/librarySizeFactors.rds"
    message:
        "[Normalization] Compute library size factors"
    script:
        "../scripts/02-normalization/librarySizeFactors.R"

rule calculateSumFactors:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/02-normalization/calculateSumFactors.rds"
    message:
        "[Normalization] Compute size factors by deconvolution"
    script:
        "../scripts/02-normalization/calculateSumFactors.R"

rule computeSpikeFactors:
    input:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    output:
        rds = "analysis/02-normalization/computeSpikeFactors.rds"
    params:
        alt = "Spikes"
    message:
        "[Normalization] Compute size factors with spike-ins"
    script:
        "../scripts/02-normalization/computeSpikeFactors.R"

rule logNormCounts:
    input:
        rds = ["analysis/01-quality-control/filterCellByQC.rds", "analysis/02-normalization/computeSpikeFactors.rds"]
    output:
        rds = "analysis/02-normalization/logNormCounts.rds"
    message:
        "[Normalization] Compute log-normalized expression values"
    script:
        "../scripts/02-normalization/logNormCounts.R"
