fx_version 'cerulean'
game 'gta5'

author 'RMC Development https://discord.gg/vtu4B7tAvA'
description 'QB-Core Pepper Spray Script'
version '1.5.0'

-- Load Shared Config
shared_script 'config.lua'

-- Load Client & Server Scripts
client_script 'client.lua'
server_script 'server.lua'

-- Required Dependencies
dependencies {
    'qb-core'
}
