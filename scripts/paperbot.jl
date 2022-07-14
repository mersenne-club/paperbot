using DrWatson
@quickactivate

#Pkg.instantiate()

using Discourse


#### ARXIV ####
using ArXiv
include(dirname(@__DIR__) * "/params/arxiv-categories.jl")

report = Dict()

for section in arxiv_category_slugs
    
    @show section
    papers = ArXiv.fetch_papers(section)

    n_fetched = length(papers)
    n_submissions = sum([!paper.update for paper in papers])

    n_posted = 0
    for paper in papers
        try
            Discourse.post_paper(paper, section)
            n_posted += 1
        catch e
            println(e)
        end
        sleep(.1)
    end

    report[section] = (fetched = n_fetched, new_submissions = n_submissions, successfully_posted = n_posted)
end
post_report(report)

#### BIORXIV ####
using BioRxiv
papers = BioRxiv.fetch_papers()

begin
    n_fetched = length(papers)
    n_posted = 0
    for paper in papers
        if paper.new 
            try
                Discourse.post_paper(paper, paper.section)
                n_posted += 1
            catch e
                println(e)
            end
            sleep(.1)
        end
    end
end


