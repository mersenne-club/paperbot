
t = string(today()) 

function fetch_raw()
    i = 0
    url = BIORXIV_API * t * '/' * t * '/' * string(i) * '/' * "json"
    response = HTTP.get(url)

    body = JSON.parse(String(response.body))
    n_papers = body["messages"][1]["count"]
    @show n_papers

    papers = body["collection"]

    while length(papers) < n_papers
        i += 100
        url = BIORXIV_API * t * '/' * t * '/' * string(i) * '/' * "json"
        response = HTTP.get(url)
        body = JSON.parse(String(response.body))
        more_papers = body["collection"]
        papers = [papers..., more_papers...]
        @show length(papers)
    end
    return papers
end

function format_paper(paper)

    authors = paper["authors"]
    title = paper["title"]
    id = paper["doi"]
    tag = replace(paper["type"], " " => "-")
    link = "https://www.biorxiv.org/content/" * id
    abstract = paper["abstract"]
    section = replace(paper["category"], " " => "-")
    

    text = join(
        [
        "<br> <span>Source: </span>" * link, 
        "<br> <span>Authors: </span>" * authors,
        "<br> <br>" * abstract
    ]
    )

    return (title=title, text = text, section = section, link = link, id = id, update = false, tag = tag)

end

fetch_papers() = map(format_paper, fetch_raw())