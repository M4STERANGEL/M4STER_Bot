local command = 'whoami'
local doc = [[```
Da información de alguien
Alias: /who
```]]

local triggers = {
	'^/who[ami]*[@'..bot.username..']*$'
}

local action = function(msg)

	if msg.reply_to_message then
		msg = msg.reply_to_message
	end

	if msg.from.last_name then
		msg.from.name = msg.from.first_name .. ' ' .. msg.from.last_name
	else
		msg.from.name = msg.from.first_name
	end

	local chat_id = math.abs(msg.chat.id)
	if chat_id > 1000000000000 then
		chat_id = chat_id - 1000000000000
	end

	local user = 'Tu eres @%s, también conocido como *%s* `[%s]`'
	if msg.from.username then
		user = user:format(msg.from.username, msg.from.name, msg.from.id)
	else
		user = 'Tu eres *%s* `[%s]`,'
		user = user:format(msg.from.name, msg.from.id)
	end

	local group = '@%s, también conocido como *%s* `[%s]`.'
	if msg.chat.type == 'private' then
		group = group:format(bot.username, bot.first_name, bot.id)
	elseif msg.chat.username then
		group = group:format(msg.chat.username, msg.chat.title, chat_id)
	else
		group = '*%s* `[%s]`.'
		group = group:format(msg.chat.title, chat_id)
	end

	local output = user .. ', y tu estás escribiendo a ' .. group

	sendMessage(msg.chat.id, output, true, msg.message_id, true)

end

return {
	action = action,
	triggers = triggers,
	doc = doc,
	command = command
}
