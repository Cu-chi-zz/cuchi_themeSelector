local wheelr, wheelg, wheelb = 0, 0, 0
local pauser, pauseg, pauseb = 0, 0, 0
local waypointr, waypointg, waypointb = 0, 0, 0
local showMenu = false

CreateThread(function() 
    TriggerServerEvent("cts:getThemeColors")
end)

RegisterCommand(Cfg.Command, function() 
    showMenu = not showMenu
    SetNuiFocus(showMenu, showMenu)
    SendNUIMessage({
        type = "show",
        show = showMenu
    })
end)

RegisterNUICallback("action", function(data, cb) 
    if data.type == "close" then
        showMenu = false
        SetNuiFocus(showMenu, showMenu)
    elseif data.type == "wheelcolor" then
        wheelr, wheelg, wheelb = data.color[1], data.color[2], data.color[3]
        
        ReplaceHudColourWithRgba(116, wheelr, wheelg, wheelb, 200)
        TriggerServerEvent("cts:setThemeColors", wheelr..","..wheelg..","..wheelb, nil)
    elseif data.type == "pausecolor" then
        pauser, pauseg, pauseb = data.color[1], data.color[2], data.color[3]

        ReplaceHudColourWithRgba(117, pauser, pauseg, pauseb, 200)
        TriggerServerEvent("cts:setThemeColors", nil, pauser..","..pauseg..","..pauseb, nil)
    elseif data.type == "waypointcolor" then
        waypointr, waypointg, waypointb = data.color[1], data.color[2], data.color[3]

        ReplaceHudColourWithRgba(142, waypointr, waypointg, waypointb, 200)
        TriggerServerEvent("cts:setThemeColors", nil, nil, waypointr..","..waypointg..","..waypointb)
    end
    
    cb("OK")
end)

RegisterNetEvent("cts:fetchThemeColors")
AddEventHandler("cts:fetchThemeColors", function(colors)
    if colors.wheel ~= "" then
        wheelcolor = splitString(colors.wheel, ",") -- Split with "," because the rgb value is stocked as a string value ("r,g,b")
        wheelr, wheelg, wheelb = tonumber(wheelcolor[1]), tonumber(wheelcolor[2]), tonumber(wheelcolor[3])
        ReplaceHudColourWithRgba(116, wheelr, wheelg, wheelb, 200)
    end

    if colors.pause ~= "" then
        pausecolor = splitString(colors.pause, ",")
        pauser, pauseg, pauseb = tonumber(pausecolor[1]), tonumber(pausecolor[2]), tonumber(pausecolor[3])
        ReplaceHudColourWithRgba(117, pauser, pauseg, pauseb, 200)
    end

    if colors.waypoint ~= "" then
        waypointcolor = splitString(colors.waypoint, ",")
        waypointr, waypointg, waypointb = tonumber(waypointcolor[1]), tonumber(waypointcolor[2]), tonumber(waypointcolor[3])
        ReplaceHudColourWithRgba(142, waypointr, waypointg, waypointb, 200)
    end
    
    SendNUIMessage({
        type = "fetch",
        wheelr = wheelr,
        wheelg = wheelg,
        wheelb = wheelb,
        pauser = pauser,
        pauseg = pauseg,
        pauseb = pauseb,
        waypointr = waypointr,
        waypointg = waypointg,
        waypointb = waypointb
    })
end)
