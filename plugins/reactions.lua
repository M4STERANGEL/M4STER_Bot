 -- Never change this plugin. It was not meant to be changed.
 -- You may add reactions. You must never remove reactions.
 -- You must never restructure. You must never disable this plugin.
 -- ~ Drew, creator, a year later.

local command = 'reacciones'
local doc = '`Da una lista de emoticonos especiales`'

local triggers = {
	['¯\\_(ツ)_/¯'] = '/shrug',
	['( ͡° ͜ʖ ͡°)'] = '/lenny',
	['(╯°□°）╯︵ ┻━┻'] = '/flip',
	['┌（┌　＾o＾）┐'] = '/homo',
	['ಠ_ಠ'] = '/look',
	['SHOTS FIRED'] = '/shots?',
	['Vete a la mierda'] = '/?mira macho'
}

 -- Generate a "help" message triggered by "/reactions".
local help = 'Reacciones:\n'
for k,v in pairs(triggers) do
	help = help .. '• ' .. v:gsub('%a%?', '') .. ': ' .. k .. '\n'
	v = v .. '[@'..bot.username..']*'
end
triggers[help] = '^/reacciones$'

local action = function(msg)
	for k,v in pairs(triggers) do
		if string.match(msg.text_lower, v) then
			sendMessage(msg.chat.id, k)
			return
		end
	end
end

return {
	action = action,
	triggers = triggers,
	doc = doc,
	command = command
}
