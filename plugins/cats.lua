if not config.thecatapi_key then
	print('Olvidaste poner la API: thecatapi_key.')
	print('cats.lua será activado, pero hay más funciones con la API.')
end

local command = 'cat'
local doc = '`Mira una imagen de un gato!`'

local triggers = {
	'^/cat[@'..bot.username..']*$'
}

local action = function(msg)

	local url = 'http://thecatapi.com/api/images/get?format=html&type=jpg'
	if config.thecatapi_key then
		url = url .. '&api_key=' .. config.thecatapi_key
	end

	local str, res = HTTP.request(url)
	if res ~= 200 then
		sendReply(msg, config.errors.connection)
		return
	end

	str = str:match('<img src="(.-)">')
	local output = '[Aquí tienes a tu gatito!!]('..str..')'

	sendMessage(msg.chat.id, output, false, nil, true)

end

return {
	action = action,
	triggers = triggers,
	doc = doc,
	command = command
}
