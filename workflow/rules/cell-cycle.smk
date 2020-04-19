rule cyclinHeatmap:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        pdf = "cyclinHeatmap.pdf"
    message:
        "[Cell cycle assignment] Plot expression of cyclins"
    script:
        "cyclinHeatmap.R"

rule phaseSingleR:
    input:
        ""
    output:
        ""
    message:
        "[Cell cycle assignment] Annotate cells into cell cycle phases"
    script:
        "phaseSingleR.R"

rule cyclone:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = "cyclone.rds"
    message:
        "[Cell cycle assignment] Classify cells into cell cycle phases"
    script:
        "cyclone.R"
