module VeryEfficientAlimentSelector

export feed_veas

using Random, Printf
using FileIO: load
using UnicodePlots: heatmap
using Cascadia
using Gumbo
using HTTP
using AbstractTrees
using Dates

include("types.jl")
include("get_menu.jl")
include("feed_veas.jl")

end # module