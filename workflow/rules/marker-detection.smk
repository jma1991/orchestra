# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule pairwiseTTests:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.rds"
    log:
        out = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise t-tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc})"
    threads:
        16
    script:
        "../scripts/marker-detection/pairwiseTTests.R"

rule combineTTests:
    input:
        rds = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.rds"
    log:
        out = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Combine pairwise t-tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    threads:
        16
    script:
        "../scripts/marker-detection/combineTTests.R"

rule pairwiseWilcox:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.rds"
    log:
        out = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise Wilcoxon rank sum tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc})"
    threads:
        16
    script:
        "../scripts/marker-detection/pairwiseWilcox.R"

rule combineWilcox:
    input:
        rds = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.rds"
    log:
        out = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Combine pairwise Wilcoxon rank sum tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    threads:
        16
    script:
        "../scripts/marker-detection/combineWilcox.R"

rule pairwiseBinom:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.rds"
    log:
        out = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise binomial tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc})"
    threads:
        16
    script:
        "../scripts/marker-detection/pairwiseBinom.R"

rule combineBinom:
    input:
        rds = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.rds"
    log:
        out = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Combine binomial tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    threads:
        16
    script:
        "../scripts/marker-detection/combineBinom.R"