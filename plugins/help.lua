 -- This plugin should go at the end of your plugin list in
 -- config.lua, but not after greetings.lua.

local help_text = '*Comandos disponibles:*'

for i,v in ipairs(plugins) do
	if v.command then
		help_text = help_text .. '\n• /' .. v.command:gsub('%[', '\\[')
	end
end

help_text = help_text .. [[

• /help <comando>
Argumentos: <requerido> \[opcional]
]]

local triggers = {
	'^/help[@'..bot.username..']*',
	'^/h[@'..bot.username..']*$'
}

local action = function(msg)

	local input = msg.text_lower:input()

	-- Attempts to send the help message via PM.
	-- If msg is from a group, it tells the group whether the PM was successful.
	if not input then
		local res = sendMessage(msg.from.id, help_text, true, nil, true)
		if not res then
			sendReply(msg, 'Iniciame por privado para poder darte la ayuda')
		elseif msg.chat.type ~= 'private' then
			sendReply(msg, 'Te he enviado mi ayuda por privado')
		end
		return
	end

	for i,v in ipairs(plugins) do
		if v.command and get_word(v.command, 1) == input and v.doc then
			local output = '*Ayuda para* _' .. get_word(v.command, 1) .. '_ *:*\n' .. v.doc
			sendMessage(msg.chat.id, output, true, nil, true)
			return
		end
	end

	sendReply(msg, 'Lo siento, no tengo ayuda para ese plugin')

end

return {
	action = action,
	triggers = triggers
}
