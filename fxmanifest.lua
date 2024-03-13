fx_version 'cerulean'
game 'gta5'
lua54 'yes'


name 'Noleggio veicolo'
author 'Jibo'
description 'Noleggio veicolo.'

client_script{
    'client.lua',
    'config.lua'
}

server_script{
    'server.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

dependency 'ox_lib'
dependency 'es_extended'