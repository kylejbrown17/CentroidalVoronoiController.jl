using CentroidalVoronoiController
using Documenter

makedocs(;
    modules=[CentroidalVoronoiController],
    authors="Kyle Brown <kylejbrown17@gmail.com> and contributors",
    repo="https://github.com/kylejbrown17/CentroidalVoronoiController.jl/blob/{commit}{path}#L{line}",
    sitename="CentroidalVoronoiController.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://kylejbrown17.github.io/CentroidalVoronoiController.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kylejbrown17/CentroidalVoronoiController.jl",
)
