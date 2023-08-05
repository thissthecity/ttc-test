fx_version 'cerulean'
game 'gta5'

description 'TTC Test Script'
author 'GFive'
version '1.0.0'

shared_scripts {
    '@ttc-libs/shared/main.lua',
    "shared/*.lua",
}

server_scripts {
    "server/*.lua",
}

client_scripts {
    "client/*.lua",
}

lua54 'yes'
