CreateThread( function()
    if GetCurrentResourceName() ~= "cuchi_themeSelector" then -- If the resource name is changed, then the resource kvp won't work
        print("^7[^6"..GetCurrentResourceName().."^7] > ^1You shouldn't change the resource name")
    end

    if Cfg.CheckVersion then
        updatePath = "/Cu-chi/cuchi_themeSelector"

        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", function(err, responseText, headers)
            curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!

            if curVersion ~= responseText then
                print("^7[^6"..GetCurrentResourceName().."^7] > ^1Version outdated: update it from ^7https://github.com"..updatePath)
            else
                print("^7[^6"..GetCurrentResourceName().."^7] > ^2Up to date!^7")
            end
        end, "GET")
    end
end)
