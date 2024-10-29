fx_version 'cerulean'
lua54 'yes'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'discord:r0bbot'

files {
  'locales/*.json',
}

shared_scripts {
  '@ox_lib/init.lua',
	'shared/config.lua',
}

server_scripts {
	'server/functions.lua',
  'server/events.lua',
}

dependencies {
  'ox_lib',
  'vorp_core'
}
