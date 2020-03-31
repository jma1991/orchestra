rule all:
    input:
        ""

include: "rules/quality-control.smk"
include: "rules/normalization.smk"
include: "rules/feature-selection.smk"
include: "rules/reduced-dimensions.smk"
include: "rules/clustering.smk"
include: "rules/marker-detection.smk"
include: "rules/cell-annotation.smk"
include: "rules/doublet-detection.smk"
include: "rules/cell-cycle.smk"