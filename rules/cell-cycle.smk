rule cyclinHeatmap:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        pdf = "cyclinHeatmap.pdf"
    script:
        "cyclinHeatmap.R"

rule phaseSingleR:
    input:
        ""
    output:
        ""
    script:
        "phaseSingleR.R"

rule cyclone:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "cyclone.rds"
    script:
        "cyclone.R"
