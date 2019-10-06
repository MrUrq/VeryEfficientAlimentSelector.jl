abstract type Restaurant end
struct Wijkanders <: Restaurant 
    name::String
    Wijkanders() = new("Wijkanders")
end
struct Linsen <: Restaurant
    name::String
    Linsen() = new("Linsen")
end
struct Arojjdii <: Restaurant
    name::String
    Arojjdii() = new("Arojj Dii")
end
struct Stockyard <: Restaurant 
    name::String
    Stockyard() = new("Stockyard")
end
struct Treindier <: Restaurant 
    name::String
    Treindier() = new("Tre Indier")
end
struct Pepperoni <: Restaurant 
    name::String
    Pepperoni() = new("Pepperoni")
end
struct Traktör <: Restaurant 
    name::String
    Traktör() = new("Traktör")
end
struct Cyrano <: Restaurant 
    name::String
    Cyrano() = new("Cyrano")
end
struct Missfajitas <: Restaurant 
    name::String
    Missfajitas() = new("Miss Fajitas")
end
struct Charliesbistro <: Restaurant 
    name::String
    Charliesbistro() = new("Charlies Bistro")
end
struct Gandhimahal <: Restaurant 
    name::String
    Gandhimahal() = new("Gandhi Mahal")
end
struct Sushime <: Restaurant 
    name::String
    Sushime() = new("Sushi Me")
end