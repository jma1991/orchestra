rule doubletCluster:
    input:
        rds = "{object}.rds"
    output:
        rds = "doubletCluster.rds"
    message:
        "[Doublet detection] Detect doublet clusters"
    script:
        "doubletCluster.R"

rule doubletCells:
    input:
        rds = "{object}.rds"
    output:
        rds = "doubletCells.rds"
    message:
        "[Doublet detection] Detect doublet cells"
    script:
        "doubletCells.R"
