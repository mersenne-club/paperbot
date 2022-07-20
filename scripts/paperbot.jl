using Discourse

using ArXiv, BioRxiv

report = Dict()

# FETCH AND POST PAPERS
include("arxivbot.jl")
include("biorxivbot.jl")

### REPORT
post_report(report)