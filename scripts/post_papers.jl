using Pkg
Pkg.activate(".")

include(dirname(@__DIR__) * "/params/categories.jl")

using ArXiv, Discourse

section = "hep-th"
papers = ArXiv.fetch_papers(section)
paper = papers[1]
Discourse.post_paper(paper, section)

for section in category_slugs
    @show section
    papers = ArXiv.fetch_papers(section)
    for paper in papers
        try
            Discourse.post_paper(paper, section)
        catch e
            println(e)
        end
        sleep(.5)
    end
end