using Discourse
include(dirname(@__DIR__) * "/params/categories.jl")

using Plots:palette, hex
colors = hex.(palette(:tab10, length(category_slugs)))

for (name, slug, color) in zip((category_names, category_slugs, colors)...)
    println((name, slug, color))
    create_category(name, slug, color, "arxiv")
end
