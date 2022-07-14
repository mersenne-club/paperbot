
biorxiv_category_names = [
    "Animal Behavior and Cognition", 
    "Biochemistry", 
    "Bioengineering",
    "Bioinformatics",
    "Biophysics",
    "Cancer Biology",
    "Cell Biology",
    "Developmental Biology",
    "Ecology",
    "Evolutionary Biology",
    "Genetics",
    "Genomics",
    "Immunology",
    "Microbiology",
    "Molecular Biology",
    "Neuroscience",
    "Paleontology",
    "Pathology",
    "Pharmacology and Toxicology",
    "Physiology",
    "Plant Biology",
    "Scientific Communication and Education",
    "Synthetic Biology",
    "Systems Biology",
    "Zoology"
]

sluggify(name) = replace(lowercase(name), " " => "-")
biorxiv_category_slugs = sluggify.(biorxiv_category_names)