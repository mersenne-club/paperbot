using Discourse, BioRxiv
papers = BioRxiv.fetch_papers();


n_fetched = length(papers)
n_posted = 0
for paper in papers
    try
        Discourse.post_paper(paper, paper.section)
        n_posted += 1
    catch e
        println(e)
        println(paper.title)
        println("----")
    end
    sleep(1)
end

report["bioRxiv"] = (fetched = n_fetched, successfully_posted = n_posted)
