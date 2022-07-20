function post_paper(paper, category)
    
    paper.update && return 

    if paper.section == category
        post = Dict(
            "title" => paper.title,
            "raw" => paper.text,
            "category" => Discourse.CATEGORIES[category],
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
            "category" => Discourse.CATEGORIES[category]
        )

        response = HTTP.post(
            DISCOURSE_URL * "posts.json", 
            HEADER, 
            JSON.json(post)
            )
    end

end