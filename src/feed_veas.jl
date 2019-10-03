function feed_veas()
    places = [
        "Wijkanders"
        "Linsen"
        "Arojj Dii"
        "Stockyard"
        "Tre Indier"
        "Pepperoni"
        "Traktör"
        "Cyrano"
        "Miss Fajitas"
        "Charlies Bistro"
        "Gandhi Mahal"
        "Sushi Me"
    ]

    places = shuffle(places)

    run(`clear`);
    for (i, place) in enumerate(places)
        @printf "Choise %-3.0f %s \n" i place 
    end

    fig_path = joinpath(dirname(pathof(VeryEfficientAlimentSelector)), "../pictures", lowercase(replace(places[1], " " => ""))*".jpg")
    img = load(fig_path)
    out = heatmap(reverse(img,dims=1); height=35, border=:none, labels=false)

    display(out)
end