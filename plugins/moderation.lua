 -- Moderation for Liberbot groups.
 -- The bot must be made an admin.
 -- Put this near the top, after blacklist.
 -- If you want to enable antisquig, put that at the top, before blacklist.

if not database.moderation then
	database.moderation = {}
end

local antisquig = {}

local commands = {

	['^/modhelp[@'..bot.username..']*$'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return end

		local output = [[
			*Usuarios:*
			• /modlist - _Lista de grupos administrados por el bot-
			*Moderadores:*
			• /modkick - _Elimina al usuario del grupo-
			• /modban - _Banea al usuario del grupo-
			*Administradores:*
			• /modadd - _Añade al grupo al sistema de moderación_
			• /modrem - _Elimina el grupo del sistema de moderadción_
			• /modprom - _Autoriza a un usuario a ser moderador_
			• /moddem - _Elimina a un moderador_
			• /modcast - _Envía un mensaje a todos los grupos moderados_
		]]
		output = output:gsub('\t', '')

		sendMessage(msg.chat.id, output, true, nil, true)

	end,

	['^/modlist[@'..bot.username..']*$'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return end

		local output = ''

		for k,v in pairs(database.moderation[msg.chat.id_str]) do
			output = output .. '• ' .. v .. ' (' .. k .. ')\n'
		end

		if output ~= '' then
			output = '*Moderadores para* _' .. msg.chat.title .. '_ *:*\n' .. output
		end

		output = output .. '*Administradores para* _' .. config.moderation.realm_name .. '_ *:*\n'
		for k,v in pairs(config.moderation.admins) do
			output = output .. '• ' .. v .. ' (' .. k .. ')\n'
		end

		sendMessage(msg.chat.id, output, true, nil, true)

	end,

	['^/modcast[@'..bot.username..']*'] = function(msg)

		local output = msg.text:input()
		if not output then
			return 'Tienes que incluir un mensaje'
		end

		if msg.chat.id ~= config.moderation.admin_group then
			return 'Este comando deberá ser ejecutado en el grupo de administración'
		end

		if not config.moderation.admins[msg.from.id_str] then
			return config.moderation.errors.not_admin
		end

		output = '*Administradores de difusión:*\n' .. output

		for k,v in pairs(database.moderation) do
			sendMessage(k, output, true, nil, true)
		end

		return 'Tu mensaje ha sido enviado'

	end,

	['^/modadd[@'..bot.username..']*$'] = function(msg)

		if not config.moderation.admins[msg.from.id_str] then
			return config.moderation.errors.not_admin
		end

		if database.moderation[msg.chat.id_str] then
			return 'Ya modero este grupo'
		end

		database.moderation[msg.chat.id_str] = {}
		return 'Ahora modero este grupo'

	end,

	['^/modrem[@'..bot.username..']*$'] = function(msg)

		if not config.moderation.admins[msg.from.id_str] then
			return config.moderation.errors.not_admin
		end

		if not database.moderation[msg.chat.id_str] then
			return config.moderation.errors.moderation
		end

		database.moderation[msg.chat.id_str] = nil
		return 'Ya no modero este grupo'

	end,

	['^/modprom[@'..bot.username..']*$'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return end

		if not config.moderation.admins[msg.from.id_str] then
			return config.moderation.errors.not_admin
		end

		if not msg.reply_to_message then
			return 'Las subidas de rango deberán ser ejecutadas desde una respuesta'
		end

		local modid = tostring(msg.reply_to_message.from.id)
		local modname = msg.reply_to_message.from.first_name

		if config.moderation.admins[modid] then
			return modname .. ' ya es un administrador.'
		end

		if database.moderation[msg.chat.id_str][modid] then
			return modname .. ' ya es un moderador'
		end

		database.moderation[msg.chat.id_str][modid] = modname

		return modname .. ' ahora es un moderador'

	end,

	['^/moddem[@'..bot.username..']*'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return end

		if not config.moderation.admins[msg.from.id_str] then
			return config.moderation.errors.not_admin
		end

		local modid = msg.text:input()

		if not modid then
			if msg.reply_to_message then
				modid = tostring(msg.reply_to_message.from.id)
			else
				return 'Las bajadas de rango deberán ser ejecutadas desde el ID o alias'
			end
		end

		if config.moderation.admins[modid] then
			return config.moderation.admins[modid] .. ' es un administrador'
		end

		if not database.moderation[msg.chat.id_str][modid] then
			return 'El usuario no es un moderador'
		end

		local modname = database.moderation[msg.chat.id_str][modid]
		database.moderation[msg.chat.id_str][modid] = nil

		return modname .. ' ya no es un moderador'

	end,

	['/modkick[@'..bot.username..']*'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return end

		if not database.moderation[msg.chat.id_str][msg.from.id_str] then
			if not config.moderation.admins[msg.from.id_str] then
				return config.moderation.errors.not_mod
			end
		end

		local userid = msg.text:input()
		local usernm = userid

		if msg.reply_to_message then
			userid = tostring(msg.reply_to_message.from.id)
			usernm = msg.reply_to_message.from.first_name
		end

		if not userid then
			return 'Las expulsiones deberán ser ejecutadas desde una respusta, ID o alias'
		end

		if database.moderation[msg.chat.id_str][userid] or config.moderation.admins[userid] then
			return 'No puedes expulsar a un moderador'
		end

		sendMessage(config.moderation.admin_group, '/kick ' .. userid .. ' de ' .. math.abs(msg.chat.id))

		sendMessage(config.moderation.admin_group, usernm .. ' expulsado de ' .. msg.chat.title .. ' por ' .. msg.from.first_name .. '.')

	end,

	['^/modban[@'..bot.username..']*'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return end

		if not database.moderation[msg.chat.id_str][msg.from.id_str] then
			if not config.moderation.admins[msg.from.id_str] then
				return config.moderation.errors.not_mod
			end
		end

		local userid = msg.text:input()
		local usernm = userid

		if msg.reply_to_message then
			userid = tostring(msg.reply_to_message.from.id)
			usernm = msg.reply_to_message.from.first_name
		end

		if not userid then
			return 'Los baneos deberáns er ejecutados desde respuestas, ID o alias'
		end

		if database.moderation[msg.chat.id_str][userid] or config.moderation.admins[userid] then
			return 'No puedes banear a un moderador'
		end

		sendMessage(config.moderation.admin_group, '/ban ' .. userid .. ' de ' .. math.abs(msg.chat.id))

		sendMessage(config.moderation.admin_group, usernm .. ' baneado de ' .. msg.chat.title .. ' por ' .. msg.from.first_name .. '.')

	end

}

if config.moderation.antisquig then
	commands['[\216-\219][\128-\191]'] = function(msg)

		if not database.moderation[msg.chat.id_str] then return true end
		if config.moderation.admins[msg.from.id_str] then return true end
		if database.moderation[msg.chat.id_str][msg.from.id_str] then return true end

		if antisquig[msg.from.id] == true then
			return
		end
		antisquig[msg.from.id] = true

		sendReply(msg, config.moderation.errors.antisquig)
		sendMessage(config.moderation.admin_group, '/kick ' .. msg.from.id .. ' de ' .. math.abs(msg.chat.id))
		sendMessage(config.moderation.admin_group, 'ANTISQUIG: ' .. msg.from.first_name .. ' expulsado de ' .. msg.chat.title .. '.')

	end
end

local triggers = {}
for k,v in pairs(commands) do
	table.insert(triggers, k)
end

local action = function(msg)

	for k,v in pairs(commands) do
		if string.match(msg.text_lower, k) then
			local output = v(msg)
			if output == true then
				return true
			elseif output then
				sendReply(msg, output)
			end
			return
		end
	end

	return true

end

 -- When a user is kicked for squiggles, his ID is added to this table.
 -- That user will not be kicked again as long as his ID is in the table.
 -- The table is emptied every five seconds.
 -- Thus the bot will not spam the group or admin group when a user posts more than one infringing messages.
local cron = function()

	antisquig = {}

end

return {
	action = action,
	triggers = triggers,
	cron = cron
}
