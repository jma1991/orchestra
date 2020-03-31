# Marker detection

rule pairwiseTTests:
    input:
        rds = "test.rds"
    output:
        rds = "pairwiseTTests-{direction}-{lfc}.rds"
    script:
        "pairwiseTTests.R"

rule pairwiseWilcox:
    input:
        rds = "test.rds"
    output:
        rds = "pairwiseWilcox-{direction}-{lfc}.rds"
    script:
        "pairwiseWilcox.R"

rule pairwiseBinom:
    input:
        rds = "test.rds"
    output:
        rds = "pairwiseBinom-{direction}-{lfc}.rds"
    script:
        "pairwiseBinom.R"

