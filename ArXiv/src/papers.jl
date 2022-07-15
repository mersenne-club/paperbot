
format_title(title) = split(title, ". (")[1]
updated(title) = occursin(title, "UPDATED")
format_abstract(abstract) = replace(abstract, "\n" => " ", "<p>" => "", "</p>" => "")
format_link(link) = "<a href =\"" * link * "\">" * link * "</a>"
extract_tag(title) = match(r"(?<=\[).+?(?=\])", title).match
extract_section(tag) = split(tag, '.')[1]
extract_id(link) = link[end-9: end]

function fetch_raw(section)
    response = HTTP.get(ARXIV_RSS * section)
    body = String(response.body)
    papers = xml_dict(body)["RDF"]["item"]
    return papers
end

function format_paper(paper)
    link = paper["link"]
    authors = paper["creator"]
    abstract = paper["description"][""]
    title = format_title(paper["title"])
    tag = extract_tag(paper["title"])
    section = extract_section(tag)
    update = updated(paper["title"])
    id = extract_id(link)

    text = join(
        [
        "<br> <span>Source: </span>" * format_link(link), 
        "<br> <span>Authors: </span>" * authors,
        "<br> <br>" * format_abstract(abstract)
    ]
    )
    return (title=title, tag = tag, text = text, section = section, link = link, update = update, id = id)
end

fetch_papers(section) = map(format_paper, fetch_raw(section))
