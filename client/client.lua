local wheelr, wheelg, wheelb = 0, 0, 0
local pauser, pauseg, pauseb = 0, 0, 0
local waypointr, waypointg, waypointb = 0, 0, 0
local showMenu = false
local kvpData = {
    ["pause"] = "",
    ["waypoint"] = "",
    ["wheel"] = ""
}

CreateThread(function()
    if not Cfg.UseResourceKvp then
        TriggerServerEvent("cts:getThemeColors")
        kvpData = nil
    else
        for key, _ in pairs(kvpData) do
            local supposedKey = "cts:"..key

            if GetResourceKvpString(supposedKey) ~= nil then -- Check if the value is saved in the user cache files
                kvpData[key] = GetResourceKvpString(supposedKey) -- Set the correct kvp key with in the correct field
                print(("%s setted with the value of %s (%s)"):format(key, supposedKey, GetResourceKvpString(supposedKey)))

                if kvpData[key] ~= "" then
                    colorData = splitString(kvpData[key], ",") -- Split with "," because the rgb value is stocked as a string value ("r,g,b")
                    
                    if key == "pause" then
                        pauser, pauseg, pauseb = tonumber(colorData[1]), tonumber(colorData[2]), tonumber(colorData[3])
                        ReplaceHudColourWithRgba(117, pauser, pauseg, pauseb, 200)
                    elseif key == "waypoint" then
                        waypointr, waypointg, waypointb = tonumber(colorData[1]), tonumber(colorData[2]), tonumber(colorData[3])
                        ReplaceHudColourWithRgba(142, waypointr, waypointg, waypointb, 200)
                    elseif key == "wheel" then
                        wheelr, wheelg, wheelb = tonumber(colorData[1]), tonumber(colorData[2]), tonumber(colorData[3])
                        ReplaceHudColourWithRgba(116, wheelr, wheelg, wheelb, 200)
                    end
                end
            else
                print(("%s is not saved in the files: %s"):format(key, tostring(GetResourceKvpString(supposedKey))))
                SetResourceKvp(supposedKey, "")
            end
        end
    end
end)

RegisterCommand(Cfg.Command, function() 
    showMenu = not showMenu
    SetNuiFocus(showMenu, showMenu)

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

        if not Cfg.UseResourceKvp then
            TriggerServerEvent("cts:setThemeColors", wheelr..","..wheelg..","..wheelb, nil, nil)
        else
            SetResourceKvp("cts:wheel", wheelr..","..wheelg..","..wheelb)
        end
    elseif data.type == "pausecolor" then
        pauser, pauseg, pauseb = data.color[1], data.color[2], data.color[3]

        ReplaceHudColourWithRgba(117, pauser, pauseg, pauseb, 200)

        if not Cfg.UseResourceKvp then
            TriggerServerEvent("cts:setThemeColors", nil, pauser..","..pauseg..","..pauseb, nil)
        else
            SetResourceKvp("cts:pause", pauser..","..pauseg..","..pauseb)
        end
    elseif data.type == "waypointcolor" then
        waypointr, waypointg, waypointb = data.color[1], data.color[2], data.color[3]

        ReplaceHudColourWithRgba(142, waypointr, waypointg, waypointb, 200)

        if not Cfg.UseResourceKvp then
            TriggerServerEvent("cts:setThemeColors", nil, nil, waypointr..","..waypointg..","..waypointb)
        else
            SetResourceKvp("cts:waypoint", waypointr..","..waypointg..","..waypointb)
        end
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
end)
