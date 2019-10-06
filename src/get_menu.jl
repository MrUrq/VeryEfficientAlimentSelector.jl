function get_menu(place::T) where T <: Restaurant end


function week(place::Traktör,html)
    qs = eachmatch(Selector("div.elementor-text-editor"),html.root)[2]

    #Current week
    week = qs[1][1].text
end
function menu_of_day(place::Traktör,html,day)

    qs = eachmatch(Selector("div.elementor-text-editor"),html.root)[2]

    #Iterate through and create a list containing the days and food items
    #This list can have problems due to site formatting
    tmp_menu = Array{String,1}()
    for elm in PreOrderDFS(qs[2].children)
        if typeof(elm) == HTMLText
            push!(tmp_menu,elm.text)
        end
    end

    #Days of week in Swedish
    dagar = ["MÅNDAG" "TISDAG" "ONSDAG" "TORSDAG" "FREDAG" "LÖRDAG" "SÖNDAG"]
    dag = dagar[day]
    
    #Find the dag in the menu, if problem with inconsistent splitting of days,
    #add the menu_item+1 food to the string
    menu_item = findfirst(occursin.(Regex(dag), tmp_menu))
    menu = tmp_menu[menu_item]
    if length(menu) < 15
        menu *= tmp_menu[menu_item+1]
    end
    
    return menu
end

function standing_menu(place,html)
    qs = eachmatch(Selector("div.elementor-text-editor"),html.root)[2]

    #Iterate through and create a list containing the days and food items
    #This list can have problems due to site formatting
    menu = Array{String,1}()
    for elm in PreOrderDFS(qs[3].children)
        if typeof(elm) == HTMLText
            push!(menu,elm.text)
        end
    end
    menu
end

function get_menu(place::Traktör, cur_day)
    url = "https://www.gbgtraktoren.se/kok-matsal/"
    res = HTTP.get(url)
    
    body = String(res.body)
    html = parsehtml(body)

    return week(place,html), menu_of_day(place,html,cur_day), standing_menu(place,html)
end

function week(place::Wijkanders,cur_date)
    "DAGENS LUNCH V "*string(week(cur_date))
end

function menu_of_day(place::Wijkanders,html,cur_date)

    qs = eachmatch(Selector("div.post-content"),html.root)

    menu = Array{String,1}()
    for elm in PreOrderDFS(qs[1].children)
        if typeof(elm) == HTMLText
            push!(menu,elm.text)
        end
    end

    #Days of week in Swedish, end with two fridays for showing on weekends
    dagar = ["Måndag" "Tisdag" "Onsdag" "Torsdag" "Fredag" "Lördag" "Söndag"]

    #Finds all days mentioned days 
    tmp_day_idx = findall(occursin.(Regex(dagar[dayofweek(cur_date)]), menu))
    tmp_menu = menu[tmp_day_idx]

    #Filter out the first day with a date greater than or equal to day
    found_days = split.(tmp_menu," ")
    for (i,found_day) in enumerate(found_days)
        date_vals = parse.(Int, split(found_day[end],"/"))
        
        # See if the found menu is for today or future
        if DateTime(Dates.year(now()),reverse(date_vals)...) == cur_date
            day_idx=tmp_day_idx[i]
            return menu[day_idx:(day_idx+6)]
        end
    end
end

function get_menu(place::Wijkanders, cur_date)
    url = "https://wijkanders.se/restaurangen/"
    res = HTTP.get(url)
    
    body = String(res.body)
    html = parsehtml(body)

    return week(place,cur_date), menu_of_day(place,html,cur_date)
end