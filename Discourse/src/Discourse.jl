module Discourse

export post_paper, create_category

using HTTP
using JSON

const DISCOURSE_URL = "https://discourse.mis.mpg.de/"
const HEADER = read(dirname(@__DIR__) * "/params/credentials-paperbot.json") |> String |> JSON.parse


function download_categories()
    response = HTTP.get(DISCOURSE_URL * "site.json", HEADER)
    body = JSON.parse(String(response.body))
    cats = body["categories"]
    return cats
end

const CATEGORIES = Dict([cat["slug"] => cat["id"] for cat in download_categories()])

function create_category(name, slug, color, parent = "test")
    
    body = Dict(
        "name" => name, 
        "color" => color, 
        "slug" => slug,
        "parent_category_id" => CATEGORIES[parent]
        )
    HTTP.post(
        DISCOURSE_URL * "categories.json", 
        HEADER, 
        JSON.json(body)
        )
end


# isletter_or_dash(c::AbstractChar) = isletter(c) || c == '-'
# function sluggify(title::AbstractString)
#     slug = replace(title, " " => "-")
#     slug = lowercase(slug)
#     slug = collect(slug)[isletter_or_dash.(collect(slug))] |> join
#     if slug[end] == '-' slug = chop(slug) end
#     return slug
# end

function post_paper(paper, category)
    
    paper.update && return 

    if paper.section == category
        post = Dict(
            "title" => paper.title,
            "raw" => paper.text,
            "category" => CATEGORIES[category],
            "tags" => [replace(paper.tag, "." => "-")]
        )

        response = HTTP.post(
            DISCOURSE_URL * "posts.json", 
            HEADER, 
            JSON.json(post)
            )

    else

        search_url = DISCOURSE_URL * "search?q=" * HTTP.escape(paper.link)
        message = """
        This is a cross posting. Please discuss the primary posting <a href="$search_url">here</a>. 
        """
        post = Dict(
            "title" => paper.title * " (CROSS-POSTING " * paper.section * ")",
            "raw" => message,
            "category" => CATEGORIES[category]
        )

        response = HTTP.post(
            DISCOURSE_URL * "posts.json", 
            HEADER, 
            JSON.json(post)
            )
    end

end

end # module
