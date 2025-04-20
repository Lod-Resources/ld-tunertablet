fx_version 'cerulean'
game 'gta5'
Version '1.1.5'
author 'l0d.'

shared_scripts {
	'shared/config.lua',
	'shared/locales.lua',
	'@ox_lib/init.lua',
}

client_scripts {
	'client/*.*',
	'shared/config.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.*',
	'shared/config.lua',
}

ui_page "html/index.html"

files {
	'html/index.html',
	'html/src/fonts/*.*',
    'html/src/images/*.*',
    'html/src/scripts/*.*',
    'html/src/style/*.*',
}

escrow_ignore {
    'shared/config.lua',
    'shared/locales.lua'
}


lua54 'yes'

