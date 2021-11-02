fx_version "cerulean"
game "gta5"

ui_page "client/ui/index.html"

files {
    "client/ui/*"
}

shared_script "config.lua"
client_script "client/*.lua"
server_script "server/*.lua"