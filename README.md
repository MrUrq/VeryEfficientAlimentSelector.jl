# VeryEfficientAlimentSelector.jl
Julia package for feeding the indecisive PhD students at VEAS.
Simply run the below command for a randomly sorted list of Chalmers Johanneberg 
campus related food options.  

```julia
julia> using VeryEfficientAlimentSelector
julia> feed_veas()
```

To see available options for another date run
```julia
julia> using Dates
julia> print_menus(Date(2019,10,7)) #year,month,day
```


To add the package run 
```julia
julia> using Pkg
julia> Pkg.add(PackageSpec(name="UnicodePlots", rev="master"))
julia> Pkg.add(PackageSpec(url="https://github.com/MrUrq/VeryEfficientAlimentSelector.jl.git"))
```