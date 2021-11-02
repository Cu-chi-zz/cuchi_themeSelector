playersDataFile, playersDataJson = LoadResourceFile(GetCurrentResourceName(), "./data/data.json"), {}

CreateThread(function() 
    if playersDataFile ~= nil then
        playersDataJson = json.decode(playersDataFile)
    end
end)

RegisterNetEvent("cts:getThemeColors")
AddEventHandler("cts:getThemeColors", function() 
    local _source = source
    local license = GetLicense(GetPlayerIdentifiers(_source))
    if playersDataFile == nil then
        playersDataJson = { 
            { 
                license = license, 
                colors = {
                    wheel = "",
                    pause = "",
                    waypoint = ""
                }
            } 
        }

        SaveResourceFile(GetCurrentResourceName(), "./data/data.json", json.encode(playersDataJson, { indent = true }), -1)
        playersDataJson = json.decode(LoadResourceFile(GetCurrentResourceName(), "./data/data.json"))
    else
        local position = GetPositionInTable(license, playersDataJson)

        if position == -1 then -- If the player is not in the data file
            playersDataJson[#playersDataJson + 1] = { 
                license = license, 
                colors = {
                    wheel = "",
                    pause = "",
                    waypoint = ""
                }
            }

            SaveResourceFile(GetCurrentResourceName(), "./data/data.json", json.encode(playersDataJson, { indent = true }), -1)
            playersDataJson = json.decode(LoadResourceFile(GetCurrentResourceName(), "./data/data.json"))
        else
            if playersDataJson[position].colors.wheel ~= "" or playersDataJson[position].colors.pause ~= "" or playersDataJson[position].colors.waypoint ~= "" then
                TriggerClientEvent("cts:fetchThemeColors", _source, playersDataJson[position].colors)
            end
        end
    end
end)

RegisterNetEvent("cts:setThemeColors")
AddEventHandler("cts:setThemeColors", function(wheelcolor, pausecolor, waypointcolor)
    local _source = source
    local license = GetLicense(GetPlayerIdentifiers(_source))

    local position = GetPositionInTable(license, playersDataJson)
    if position ~= -1 then
        if wheelcolor ~= nil then
            playersDataJson[position].colors.wheel = wheelcolor
        end

        if pausecolor ~= nil then
            playersDataJson[position].colors.pause = pausecolor
        end

        if waypointcolor ~= nil then
            playersDataJson[position].colors.waypoint = waypointcolor
        end

        SaveResourceFile(GetCurrentResourceName(), "./data/data.json", json.encode(playersDataJson, { indent = true }), -1)
        playersDataJson = json.decode(LoadResourceFile(GetCurrentResourceName(), "./data/data.json"))
    end
end)