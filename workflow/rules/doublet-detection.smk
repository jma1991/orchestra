rule doubletCluster:
    input:
        rds = "test.rds"
    output:
        rds = "doubletCluster.rds"
    message:
        "[Doublet detection] Detect doublet clusters"
    script:
        "doubletCluster.R"

rule doubletCells:
    input:
        rds = "temp.rds"
    output:
        rds = "doubletCells.rds"
    message:
        "[Doublet detection] Detect doublet cells"
    script:
        "doubletCells.R"
