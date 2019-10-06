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

    #Days of week in Swedish, end with two mondays for showing on weekends
    dagar = ["MÅNDAG" "TISDAG" "ONSDAG" "TORSDAG" "FREDAG" "MÅNDAG" "MÅNDAG"]
    dag = dagar[day]
    
    #Find the dag in the menu, if problem of inconsistent splitting of days,
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

function get_menu(place::Traktör)
    url = "https://www.gbgtraktoren.se/kok-matsal/"
    res = HTTP.get(url)
    
    body = String(res.body)
    html = parsehtml(body)

    day = Dates.dayofweek(now())
    
    return week(place,html), menu_of_day(place,html,day), standing_menu(place,html)
end