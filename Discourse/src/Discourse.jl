module Discourse

export post_paper, create_category, post_report, CATEGORIES

using HTTP
using JSON

const DISCOURSE_URL = "https://discourse.mersenne.club/"#"https://discourse.mis.mpg.de/"
const HEADER = read(dirname(@__DIR__) * "/params/credentials-paperbot.json") |> String |> JSON.parse


include("categories.jl")
const CATEGORIES = Dict([cat["slug"] => cat["id"] for cat in download_categories()])

include("papers.jl")
include("reports.jl")

end # module

