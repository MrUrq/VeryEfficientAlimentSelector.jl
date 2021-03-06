module VeryEfficientAlimentSelector
@doc read(joinpath(dirname(@__DIR__), "README.md"), String) VeryEfficientAlimentSelector


export  feed_veas,
        print_menus

using Random, Printf
using FileIO: load
using UnicodePlots: heatmap
using Images
using Cascadia
using Gumbo
using HTTP
using AbstractTrees
using Dates

include("types.jl")
include("get_menu.jl")
include("feed_veas.jl")

const places = [
    Wijkanders()
    Linsen()
    Arojjdii()
    Stockyard()
    Treindier()
    Pepperoni()
    Traktör()
    Cyrano()
    Missfajitas()
    Charliesbistro()
    Gandhimahal()
    Sushime()
]

end # module