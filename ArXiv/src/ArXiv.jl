module ArXiv

export fetch_papers

ARXIV_URL = "http://export.arxiv.org/rss/"

using HTTP
using XMLDict

format_title(title::AbstractString) = split(title, ". (")[1]
updated(title::AbstractString) = occursin(title, "UPDATED")
format_abstract(abstract::AbstractString) = replace(abstract, "\n" => " ", "<p>" => "", "</p>" => "")
format_link(link::AbstractString) = "<a href =\"" * link * "\">" * link * "</a>"
extract_tag(title::AbstractString) = match(r"(?<=\[).+?(?=\])", title).match
extract_section(tag::AbstractString) = split(tag, '.')[1]
extract_id(link::AbstractString) = link[end-9: end]

function fetch_raw(section)
    response = HTTP.get(ARXIV_URL * section)
    body = String(response.body)
    papers = xml_dict(body)["RDF"]["item"]
    return papers
end

function format_paper(paper)
    
    link = paper["link"]
    title = format_title(paper["title"])
    tag = extract_tag(paper["title"])
    section = extract_section(tag)
    update = updated(paper["title"])
    id = extract_id(link)

    text = join(
        [
        "<br> <span>Source: </span>" * format_link(paper["link"]), 
        "<br> <span>Authors: </span>" * paper["creator"],
        "<br> <br>" * format_abstract(paper["description"][""])
    ]
    )
    return (title=title, tag = tag, text = text, section = section, link = link, update = update, id = id)
end

fetch_papers(section) = map(format_paper, fetch_raw(section))

end # module
