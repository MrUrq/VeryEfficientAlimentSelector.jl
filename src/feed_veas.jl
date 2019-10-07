function feed_veas()

    shuffled_places = shuffle(places)

    run(`clear`);
    print_menus(Date(now()),shuffled_places)

    fig_path = joinpath(dirname(pathof(VeryEfficientAlimentSelector)), "../pictures", lowercase(replace(shuffled_places[1].name, " " => ""))*".jpg")
    img = load(fig_path)
    out = heatmap(reverse(img,dims=1); height=35, border=:none, labels=false)

    display(out)
end

function print_menus(cur_time=Date(now()),places=places)
    @printf "Menu for week %.0f\n" Dates.week(cur_time)
    for (i, place) in enumerate(places)
        @printf "Choise %-3.0f %s \n" i place.name
        
        print_menu(place, Date(cur_time))
    end
end

function print_menu(place::T, cur_date) where T <: Restaurant
end

function print_menu(place::Traktör, cur_date)
    try 
        menu = get_menu(place, dayofweek(cur_date))
        week_nr = parse(Int,match(r"[0-9].",menu[1]).match)
        
        #This does not work sometimes when Traktör forget to update the menu
        #@assert week_nr == week(cur_date) #Make sure menu for correct date could be found
        
        @printf "\t %s \n" menu[1]
        @printf "\t\t %s \n" menu[2]
        @printf "\t %s \n" "Stående alternativ:"
        for opt in menu[3]
            @printf "\t\t %s \n" opt
        end
    catch
        @printf "\t No menu available \n"
    end
end

function print_menu(place::Wijkanders, cur_date)
    try 
        menu = get_menu(place, cur_date)  
        @assert menu[2] != nothing         #Make sure menu could be found

        @printf "\t %s \n" menu[1]
        for opt in menu[2]
            @printf "\t\t %s \n" opt
        end
    catch
        @printf "\t No menu available \n"
    end
end