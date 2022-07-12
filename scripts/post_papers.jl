using Pkg
Pkg.activate(".")

include(dirname(@__DIR__) * "/params/categories.jl")

using ArXiv, Discourse

for section in category_slugs
    @show section
    papers = ArXiv.fetch_papers(section)
    
    for paper in papers
        try
            Discourse.post_paper(paper, section)
        catch e
            println(e)
        end
    end
end