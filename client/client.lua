local r, g, b = 255, 255, 255
local commandDelay = 0
local showMenu = false

RegisterCommand(Cfg.Command, function(_, a) 
    if GetGameTimer() - commandDelay > 1000 then
        commandDelay = GetGameTimer()
        showMenu = not showMenu
        SetNuiFocus(showMenu, showMenu)
        SendNUIMessage({
            type = "show",
            show = showMenu
        })
    else
        NotificationText("Please don't ~r~spam~s~ this command!")
    end
end)

function NotificationText(text)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, true)
end

RegisterNUICallback("action", function(data, cb) 
    if data.type == "close" then
        showMenu = false
        SetNuiFocus(showMenu, showMenu)
    elseif data.type == "wheelcolor" then
        r, g, b = data.color[1], data.color[2], data.color[3]
        ReplaceHudColourWithRgba(116, r, g, b, 200)
        ReplaceHudColourWithRgba(117, r, g, b, 200)
    end

    cb("OK")
end)