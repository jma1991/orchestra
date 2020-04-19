rule perCellQCMetrics:
    input:
        rds = ".test/LunSpikeInData.rds"
    output:
        rds = "results/quality-control/perCellQCMetrics.rds"
    message:
        "[Quality Control] Compute per-cell quality control metrics"
    script:
        "../scripts/quality-control/perCellQCMetrics.R"

rule plotCellQCMetrics:
    input:
        rds = "results/quality-control/perCellQCMetrics.rds"
    output:
        pdf = "results/quality-control/plotCellQCMetrics.pdf"
    message:
        "[Quality Control] Plot per-cell quality control metrics"
    script:
        "../scripts/quality-control/plotCellQCMetrics.R"

rule plotColData:
    input:
        rds = "results/quality-control/perCellQCMetrics.rds"
    output:
        pdf = "results/quality-control/plotColData.pdf"
    params:
        alt = "ERCC",
        sub = "MT"
    message:
        "[Quality Control] Plot proportion of {params.alt} against {params.sub}"
    script:
        "plotColData.R"

rule fixedPerCellQC:
    input:
        rds = "results/quality-control/perCellQCMetrics.rds"
    output:
        rds = "results/quality-control/fixedPerCellQC.rds"
    params:
        sub = "MT"
        alt = ["ERCC", "SIRV"]
    script:
        "../scripts/quality-control/fixedPerCellQC.R"

rule quickPerCellQC:
    input:
        rds = "results/quality-control/perCellQCMetrics.rds"
    output:
        rds = "results/quality-control/quickPerCellQC.rds"
    params:
        alt = ["ERCC", "SIRV"],
        sub = "MT"
    script:
        "../scripts/quality-control/quickPerCellQC.R"

rule adjOutlyingness:
    input:
        rds = "perCellQCMetrics.rds"
    output:
        rds = "results/quality-control/adjOutlyingness.rds"
    message:
        "[Quality Control] Identify outliers based on the per-cell quality control metrics"
    script:
        "../scripts/quality-control/adjOutlyingness.R"

rule eulerPerCellQC:
    input:
        rds = ["fixedPerCellQC.rds", "quickPerCellQC.rds", "adjOutlyingness.rds"]
    output:
        pdf = "results/quality-control/eulerPerCellQC.pdf"
    message:
        "[Quality Control] Compare low-quality cells"
    script:
        "../scripts/quality-control/eulerPerCellQC.R"

rule filterCellByQC:
    input:
        rds = ["SingleCellExperiment.rds", "quickPerCellQC.rds"]
    output:
        rds = "filterCellByQC.rds"
    message:
        "[Quality Control] Remove low-quality cells"
    script:
        "../scripts/quality-control/filterCellByQC.R"
