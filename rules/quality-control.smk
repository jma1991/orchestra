rule perCellQCMetrics:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        rds = "perCellQCMetrics.rds"
    message:
        "Compute per-cell quality control metrics"
    script:
        "perCellQCMetrics.R"

rule plotCellQCMetrics:
    input:
        rds = "perCellQCMetrics.rds"
    output:
        pdf = "plotCellQCMetrics.pdf"
    message:
        "Plot per-cell quality control metrics"
    script:
        "plotCellQCMetrics.R"

rule fixedPerCellQC:
    input:
        rds = "perCellQCMetrics.rds"
    output:
        rds = "fixedPerCellQC.rds"
    script:
        "fixedPerCellQC.R"

rule quickPerCellQC:
    input:
        rds = "perCellQCMetrics.rds"
    output:
        rds = "quickPerCellQC.rds"
    script:
        "quickPerCellQC.R"

rule adjOutlyingness:
    input:
        rds = "perCellQCMetrics.rds"
    output:
        rds = "adjOutlyingness.rds"
    script:
        "adjOutlyingness.R"

rule eulerPerCellQC:
    input:
        rds = ["fixedPerCellQC.rds", "quickPerCellQC.rds", "adjOutlyingness.rds"]
    output:
        pdf = "eulerPerCellQC.pdf"
    script:
        "eulerPerCellQC.R"

rule filterCellByQC:
    input:
        rds = ["SingleCellExperiment.rds", "quickPerCellQC.rds"]
    output:
        rds = "filterCellByQC.rds"
    script:
        "filterCellByQC.R"
