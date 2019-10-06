function feed_veas()
    places = [
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

    places = shuffle(places)

    run(`clear`);
    for (i, place) in enumerate(places)
        @printf "Choise %-3.0f %s \n" i place.name
        print_menu(place)
    end

    fig_path = joinpath(dirname(pathof(VeryEfficientAlimentSelector)), "../pictures", lowercase(replace(places[1].name, " " => ""))*".jpg")
    img = load(fig_path)
    out = heatmap(reverse(img,dims=1); height=35, border=:none, labels=false)

    display(out)
end

function print_menu(place::T) where T <: Restaurant
end

function print_menu(place::Traktör)
    menu = get_menu(place)
    @printf "\t %s \n" menu[1]
    @printf "\t\t %s \n" menu[2]
    @printf "\t %s \n" "Stående alternativ:"
    for opt in menu[3]
        @printf "\t\t %s \n" opt
    end
end