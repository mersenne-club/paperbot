module ArXiv

export fetch_papers

ARXIV_RSS = "https://export.arxiv.org/rss/"
#ARXIV_API = "https://export.arxiv.org/api/"

using HTTP
using XMLDict

include("papers.jl")

end # module
