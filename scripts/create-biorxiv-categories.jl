using Discourse
include(dirname(@__DIR__) * "/params/biorxiv-categories.jl")

using Plots:palette, hex
colors = hex.(palette(:tab10, length(biorxiv_category_slugs)))

for (name, slug, color) in zip((biorxiv_category_names, biorxiv_category_slugs, colors)...)
    println((name, slug, color))
    try 
        create_category(name, slug, color, "biorxiv")
    catch e
        println(e)
    end
end
