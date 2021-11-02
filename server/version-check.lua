if Cfg.CheckVersion then
    CreateThread( function()
        updatePath = "/Cu-chi/cuchi_themeSelector"

        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", function(err, responseText, headers)
            curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!

            if curVersion ~= responseText then
                print("^7[^6"..GetCurrentResourceName().."^7] > ^1Version outdated: update it from ^7https://github.com"..updatePath)
            else
                print("^7[^6"..GetCurrentResourceName().."^7] > ^2Up to date!^7")
            end
        end, "GET")
    end)
end