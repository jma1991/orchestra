# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule pairwiseTTests:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.rds"
    params:
        direction = "{direction}",
        lfc = "{lfc}"
    log:
        out = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise t-tests (direction = {wildcards.direction}, lfc = {wildcards.lfc})"
    script:
        "../scripts/marker-detection/pairwiseTTests.R"

rule pairwiseWilcox:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.rds"
    params:
        direction = "{direction}",
        lfc = "{lfc}"
    log:
        out = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise Wilcoxon rank sum tests (direction = {wildcards.direction}, lfc = {wildcards.lfc})"
    script:
        "../scripts/marker-detection/pairwiseWilcox.R"

rule pairwiseBinom:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.rds"
    params:
        direction = "{direction}",
        lfc = "{lfc}"
    log:
        out = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise binomial tests (direction = {wildcards.direction}, lfc = {wildcards.lfc})"
    script:
        "../scripts/marker-detection/pairwiseBinom.R"

rule combineMarkers:
    input:
        rds = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineMarkers.{test}.{direction}.{lfc}.{pval}.rds"
    params:
        pval.type = "{direction}",
    log:
        out = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise t-tests (direction = {wildcards.direction}, lfc = {wildcards.lfc})"
    script:
        "../scripts/marker-detection/pairwiseTTests.R"