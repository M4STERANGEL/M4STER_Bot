local triggers = {
	'^/reiniciar[@'..bot.username..']*',
	'^/stop[@'..bot.username..']*'
}

local action = function(msg)

	if msg.from.id ~= config.admin then
		return
	end

	if msg.date < os.time() then return end

	if msg.text:match('^/reiniciar') then
		bot_init()
		sendReply(msg, 'Bot reiniciado')
	elseif msg.text:match('^/stop') then
		is_started = false
		sendReply(msg, 'Bot detenido')
	end

end

return {
	action = action,
	triggers = triggers
}

