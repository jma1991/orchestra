rule doubletCluster:
    input:
        rds = "test.rds"
    output:
        rds = "doubletCluster.rds"
    script:
        "doubletCluster.R"

rule doubletCells:
    input:
        rds = "temp.rds"
    output:
        rds = "doubletCells.rds"
    script:
        "doubletCells.R"
