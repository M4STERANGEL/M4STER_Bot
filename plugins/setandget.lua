database.setandget = database.setandget or {}

local command = 'set <nombre> <valor>'
local doc = [[```
/set <nombre> <valor>
Guarda el valor con ese nombre
Usa "/set <nombre> --" para eliminar el valor
/get [nombre]
Devuelve el valor que hay en ese nombre
```]]

local triggers = {
	'^/set',
	'^/get'
}

local action = function(msg)

	local input = msg.text:input()
	database.setandget[msg.chat.id_str] = database.setandget[msg.chat.id_str] or {}

	if msg.text_lower:match('^/set') then

		if not input then
			sendMessage(msg.chat.id, doc, true, nil, true)
			return
		end

		local name = get_word(input:lower(), 1)
		local value = input:input()

		if not name or not value then
			sendMessage(msg.chat.id, doc, true, nil, true)
		elseif value == '--' or value == '—' then
			database.setandget[msg.chat.id_str][name] = nil
			sendMessage(msg.chat.id, 'That value has been deleted.')
		else
			database.setandget[msg.chat.id_str][name] = value
			sendMessage(msg.chat.id, '"' .. name .. '" has been set to "' .. value .. '".', true)
		end

	elseif msg.text_lower:match('^/get') then

		if not input then
			local output
			if table_size(database.setandget[msg.chat.id_str]) == 0 then
				output = 'No hay valores guardados aquí.'
			else
				output = '*Lista de valores guardados:*\n\n'
				for k,v in pairs(database.setandget[msg.chat.id_str]) do
					output = output .. '• ' .. k .. ': `' .. v .. '`\n'
				end
			end
			sendMessage(msg.chat.id, output, true, nil, true)
			return
		end

		local output
		if database.setandget[msg.chat.id_str][input:lower()] then
			output = '`' .. database.setandget[msg.chat.id_str][input:lower()] .. '`'
		else
			output = 'No hay valores guardados con este nombre'
		end

		sendMessage(msg.chat.id, output, true, nil, true)

	end

end

return {
	action = action,
	triggers = triggers,
	doc = doc,
	command = command
}
