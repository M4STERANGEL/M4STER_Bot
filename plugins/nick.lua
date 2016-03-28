local command = 'nick <nickname>'
local doc = [[```
/nick <nickname>
Ponte un nick. Usa "/nick --" para eliminarlo.
```]]

local triggers = {
	'^/nick[@'..bot.username..']*'
}

local action = function(msg)

	local target = msg.from

	if msg.from.id == config.admin and msg.reply_to_message then
		target = msg.reply_to_message.from
		target.id_str = tostring(target.id)
		target.name = target.first_name
		if target.last_name then
			target.name = target.first_name .. ' ' .. target.last_name
		end
	end

	local output
	local input = msg.text:input()
	if not input then
		if database.users[target.id_str].nickname then
			output = target.name .. '\'s nickname is "' .. database.users[target.id_str].nickname .. '".'
		else
			output = target.name .. ' no tiene nick actualmente.'
		end
	elseif string.len(input) > 32 then
		output = 'El límite de carácteres es 32'
	elseif input == '--' or input == '—' then
		database.users[target.id_str].nickname = nil
		output = target.name .. '\'s ha eliminado su nick'
	else
		database.users[target.id_str].nickname = input
		output = target.name .. '\'s se ha puesto de nick "' .. input .. '".'
	end

	sendReply(msg, output)

end

return {
	action = action,
	triggers = triggers,
	doc = doc,
	command = command
}