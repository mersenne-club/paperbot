
function download_categories()
    response = HTTP.get(DISCOURSE_URL * "site.json", HEADER)
    body = JSON.parse(String(response.body))
    cats = body["categories"]
    return cats
end



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
