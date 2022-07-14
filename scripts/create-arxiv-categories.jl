using Discourse
include(dirname(@__DIR__) * "/params/arxiv-categories.jl")

using Plots:palette, hex
colors = hex.(palette(:tab10, length(arxiv_category_slugs)))

for (name, slug, color) in zip((arxiv_category_names, arxiv_category_slugs, colors)...)
    println((name, slug, color))
    create_category(name, slug, color, "arxiv")
end
