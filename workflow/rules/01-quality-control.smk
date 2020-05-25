rule perCellQCMetrics:
    input:
        rds = ".test/mockSCE.rds"
    output:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    message:
        "[Quality Control] Compute per-cell quality control metrics"
    script:
        "../scripts/01-quality-control/perCellQCMetrics.R"

rule plotCellQCMetrics:
    input:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    output:
        pdf = "analysis/01-quality-control/plotCellQCMetrics.pdf"
    params:
        alt = "Spikes"
    message:
        "[Quality Control] Plot per-cell quality control metrics"
    script:
        "../scripts/01-quality-control/plotCellQCMetrics.R"

rule plotColData:
    input:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    output:
        pdf = "analysis/01-quality-control/plotColData-{params.alt}-vs-{params.sub}.pdf"
    params:
        alt = "ERCC",
        sub = "MT"
    message:
        "[Quality Control] Plot proportion of {params.alt} against {params.sub}"
    script:
        "plotColData.R"

rule fixedPerCellQC:
    input:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    output:
        rds = "analysis/01-quality-control/fixedPerCellQC.rds"
    params:
        alt = "Spikes"
    script:
        "../scripts/01-quality-control/fixedPerCellQC.R"

rule quickPerCellQC:
    input:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    output:
        rds = "analysis/01-quality-control/quickPerCellQC.rds"
    params:
        alt = "Spikes"
    script:
        "../scripts/01-quality-control/quickPerCellQC.R"

rule adjOutlyingness:
    input:
        rds = "analysis/01-quality-control/perCellQCMetrics.rds"
    output:
        rds = "analysis/01-quality-control/adjOutlyingness.rds"
    params:
        alt = "Spikes"
    message:
        "[Quality Control] Identify outliers based on the per-cell quality control metrics"
    script:
        "../scripts/01-quality-control/adjOutlyingness.R"

rule eulerPerCellQC:
    input:
        rds = expand("analysis/01-quality-control/{object}.rds", object = ["fixedPerCellQC", "quickPerCellQC", "adjOutlyingness"])
    output:
        pdf = "analysis/01-quality-control/eulerPerCellQC.pdf"
    message:
        "[Quality Control] Compare low-quality cells"
    script:
        "../scripts/01-quality-control/eulerPerCellQC.R"

rule filterCellByQC:
    input:
        rds = [".test/mockSCE.rds", "analysis/01-quality-control/quickPerCellQC.rds"]
    output:
        rds = "analysis/01-quality-control/filterCellByQC.rds"
    message:
        "[Quality Control] Remove low-quality cells"
    script:
        "../scripts/01-quality-control/filterCellByQC.R"
