fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'DFNZ'
description 'change your name easy ingame'
version '1.0.5'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

files {
    "locales/*.json"
}

client_scripts {
    "client/client.lua",
    "config.lua",
}

server_script {
    "@mysql-async/lib/MySQL.lua",
    "server/server.lua",
    "config.lua"
}
