module BioRxiv

export fetch_papers

BIORXIV_API = "https://api.biorxiv.org/details/biorxiv/"

using HTTP
using JSON
using XMLDict
using Dates

include("papers.jl")

end # module