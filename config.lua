return {
	bot_api_key = '',
	google_api_key = '',
	google_cse_key = '',
	lastfm_api_key = '',
	owm_api_key = '',
	biblia_api_key = '',
	thecatapi_key = '',
	nasa_api_key = '',
	yandex_key = '',
	simsimi_key = '',
	simsimi_trial = true,
	time_offset = 3600,
	lang = 'es',
	-- If you change this, make sure you also modify launch-tg.sh.
	cli_port = 4567,
	admin = --Tu ID,
	admin_name = '',
	log_chat = nil,
	about_text = [[
Bot con la API de @M4STER_Bot

Envía /help para empezar.
]]	,
	errors = {
		connection = 'Error de Conexión',
		results = 'No hay resultados',
		argument = 'Argumento Inválido',
		syntax = 'Sintaxis Inválida',
		chatter_connection = 'No me apetece hablar ahora',
		chatter_response = 'No se que decir ahora'
	},
	greetings = {
		['Hola, #NAME.'] = {
			'hey',
			'como estás',
			'buenos días',
			'buenas tardes',
			'buenas noches'
		},
		['Chao, #NAME.'] = {
			'adiós',
			'hasta luego',
			'espero verte luego',
			'buenas noches'
		},
		['Bienvenido de nuevo, #NAME.'] = {
			'Estoy en casa',
			'Estoy de vuelta'
		},
		['Gracias, #NAME.'] = {
			'muchas gracias',
			'un placer'
		}
	},
	moderation = {
		admins = {
			['000000000'] = ''
		},
		errors = {
			antisquig = 'Este grupo solo es en inglés',
			moderation = 'No administro este grupo',
			not_mod = 'Este comando deberá ser ejecutado por un moderador',
			not_admin = 'Este comando deberáser ejecutado por un administrador',
		},
		admin_group = 1043210456,
		realm_name = 'Grupo de Control del Bot',
		antisquig = false
	},
	plugins = {
		'control.lua',
		'about.lua',
		'floodcontrol.lua',
		'ping.lua',
		'whoami.lua',
		'nick.lua',
		'echo.lua',
		'gSearch.lua',
		'gImages.lua',
		'gMaps.lua',
		'youtube.lua',
		'wikipedia.lua',
		'hackernews.lua',
		'imdb.lua',
		'calc.lua',
		'urbandictionary.lua',
		'time.lua',
		'eightball.lua',
		'reactions.lua',
		'dice.lua',
		'reddit.lua',
		'xkcd.lua',
		'slap.lua',
		'commit.lua',
		'pun.lua',
		'pokedex.lua',
		'bandersnatch.lua',
		'currency.lua',
		'cats.lua',
		'hearthstone.lua',
		'shout.lua',
		'apod.lua',
		'patterns.lua',
        'help.lua',
		-- Put new plugins above this line.
	}
}
