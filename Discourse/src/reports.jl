function post_report(report)

    sections = keys(report)
    
    post = Dict(
            "title" => "Report for " * string(today()),
            "raw" => join(
                ["$section: $(report[section])" for section in sections],
                 "\n"),
            "category" => CATEGORIES["reports"],
            "tags" => ["report"]
        )

    HTTP.post(
            DISCOURSE_URL * "posts.json", 
            HEADER, 
            JSON.json(post)
            )
end