#Activar más plugins

Si quieres activar los plugins que están desactivados por defecto, deberás añadirlos en el archivo `config.lua`, entre las dos líneas que están marcadas.

<b>Ten en cuenta que algunos plugins necesitan una locacalización especial, por lo que ten cuidado al ponerlos</b>

* * *

#Usar las APIs
<b>Algunos plugins necesitan unas APIs para funcionar, por lo que tendrás que solicitarlas a las webs correspondientes:</b>

 - weather.lua: Clave [OpenWeatherMap](http://openweathermap.org) API
 - lastfm.lua: Clave [last.fm](http://last.fm) API
 - bible.lua: Clave [Biblia](http://biblia.com) API
 - cats.lua: Clave [The Cat API](http://thecatapi.com) API key `(opcional)`
 - gImages.lua: Clave [Google](http://console.developers.google.com) API y Clave CSE (Custom Search Engine)
 - youtube.lua: Clave [Google](http://console.developers.google.com) API
 - apod.lua: Clave [NASA](http://api.nasa.gov) API
 - translate.lua: Clave [Yandex](https://tech.yandex.com/keys/get/?service=trnsl) API
 - chatter.lua: Clave [SimSimi](http://developer.simsimi.com/signUp) API

* * *

#Plugins
M4STER_Bot usa un sistema similar de plugins a yagop [Telegram-Bot](http://github.com/yagop/telegram-bot). Pretendo que sea más facil de usar de esta forma para los que ya trabajaron con yagop, TeleSeed o DBTeam.

La mayoría de plugins están hechos de tal forma que todos los puedan usar, pero otros no, como los de [Liberbot](#Liberbot-related_plugins), o [para ser usados por el admin del bot](#Control_plugins). Mira la lista de plugins para saber más.

Un plugin puede tener varios componentes:

| Componente | Descripción | Requerido? |
|:-----------|:------------|:-----------|
| action | La función principal. Usa `msg` como argumento | SI |
| triggers | Una tabla de comandos que usa el plugin. Usa unas funciones de lua | SI |
| cron | Una función que llama al plugin aproximadamente cada minuto | NO |
| command | La sintaxis y comando principal. Se pone en la ayuda del bot | NO |
| doc | COmo se usa y otra ayuda para el plugin. Se puede saber con el comando /help | NO |

La función `on_msg_receive()` añade algunas variables a la tabla `msg` según tus preferencias. Las siguientes se explican solas: `msg.from.id_str`, `msg.to.id_str`, `msg.chat.id_str`, `msg.text_lower`, `msg.from.name`.

Dar valores desde `action()` son opcionales, pero suele tener un efecto positivo en el bot. Si tiene que dar una tabla, esa tabla se converitrá en un `msg`, y `on_msg_receive`continuará la función. Si da una respuesta `true`, continuará con el actual `msg`.

Cuando una función o cron falla, la función `handle_exception()`, localizada en el archivo utilities.lua, intenta resolverlo y también se queda grabado en la consola o se envía al chat que está definido como `log_chat` en config.lua.


Muchas funciones están definidas en utilities.lua.

* * *

#Plugins de Control
Algunos plugins están hechos para ser usados por el creador del bot.

| Plugin | Command | Function |
|:-------|:--------|:---------|
| control.lua | /reiniciar | Reinicia el bot |
| control.lua | /stop | Detiene el bot de forma segura |
| blacklist.lua | /blacklist | Permite a los admins decir que gente no puede usar el bot |
| shell.lua | /run | Ejecuta comandos en la terminal actual |
| luarun.lua | /lua | Ejecuta comandos Lua que el bot interpretará |

* * *

#Administración {administration.lua}
<b>No recomiendo que useis este plugin. Mejor usad otros bots, como el [DBTeam](https://github.com/josepdal/dbteam)</b>
<br>
EL plugin de administración añade una función al bot para moderar grupos automaticamente, soportando tanto grupos normales como supergrupos. Esto funciona enviado comandos vía TCP a una instancia de Telegram que es ejecutada en la propia cuenta del propietario del bot.

Para empezar, ejecuta `./tg-install.sh`. Ten en cuenta que esta script está diseñada para Ubuntu/Debian. Si tu estás en Arch (la otra alternativa "aceptable"), tendrás que hacerlo manualmente. En este caso, ten en cuenta que M4STER_Bot usa la branch test de Telegram, y el paquete `telegram-cli-git` no será suficiente puesto que no tiene soporte para supergrupos.

Una vez la instalación ha concluido, activa el plugin `administration.lua` en tu plugin de configuración. Podrás cambiar el puerto TCP (4567); pero en este caso, ten en cuenta de cambiarlo también en `tg-launch.sh`. Ejecuta `./tg-launch.sh` e un terminal distinto. Tendrás que meter tu número de teléfono y seguir todo el proceso de login la primera vez. La script está diseñada para cerrarse unos segundos después, por lo que tendrás que ejecutar Control+C para salir.

Mientras el tg-cli está funciona, deberás ejecutar M4STER_Bot en otro terminal para tener acceso a otros comandos de administración automatizados. La base de datos de administarción se almacena en `administration.json`. 
Para comanezar a usar M4STER_Bot como adinistrador de grupos (ten en cuenta que deberás ser administrador del grupo ), envía `/gadd` a ese grupo. Para una lista de comandos, escribe `/ahelp`. Debajo teneis una tablita que lo indica todo.

| Comando | Fucnión | Rango de Privilegio | Interno? |
|:--------|:---------|:----------|:----------|
| /groups | Da una lista de grupos administrados (excepto los exclidos como "unlisted") | 1 | NO |
| /ahelp | Da una lista de los comandos disponibles junto con su nivel de privilegio | 1 | SI |
| /ops | Da una lista de moderadores y governantes | 1 | SI |
| /desc | Da una lista con el link, reglas y moderadores del grupo | 1 | SI |
| /rules | Da las reglas del grupo | 1 | SI |
| /motd | Da al grupo el mensaje del día | 1 | SI |
| /link | Da el link del grupo | 1 | SI |
| /leave | Elimina al usuario que lo escribió del grupo | 1 | SI |
| /kick | Elimina a ese usuario del grupo | 2 | SI |
| /ban | Banea a ese usuario del grupo | 2 | SI|
| /unban | Desbanea a ese usuario del grupo | 2 | SI |
| /changerule | Cambia una regla de grupo individual | 3 | SI |
| /setrules | Cambia las reglas del grupo | 3 | SI |
| /setmotd | Cambia el mensaje del día | 3 | SI |
| /setlink | Cambia el link del grupo | 3 | SI |
| /flag | Da una lista de reglas disponibles | 3 | SI |
| /mod | Registra a ese usuario como moderador | 3 | SI |
| /demod | Degrada a ese usuario a miembro | 3 | SI |
| /gov | Registra a ese usuario como governador | 4 | SI |
| /degov | Degrada a ese usuario a miembro | 4 | SI |
| /hammer | Banea a ese usuario globalmente, y lo marca en la blacklist | 4 | NO |
| /unhammer | Elimina el baneo global a ese usuario, y lo elimina de la blacklist | 4 | NO |
| /admin | Nombra a ese usuario como administrador | 5 | NO |
| /deadmin | Degrada a ese usuario a miembro | 5 | NO |
| /gadd | Añade el grupo al sistema de administración | 5 | NO |
| /grem | Elimina ese grupo del sistema de administración | 5 | SI |
| /broadcast | Difunde un mensaje por todos los grupos administrados | 5 | NO |

Los comandos internos solo funcionan en un grupo administrado.

### Description of Privileges

| # | Title | Description | Scope |
|:-:|:------|:------------|:------|
| 0 | Banned | Cannot enter the group(s). | Either |
| 1 | User | Default rank. | Local |
| 2 | Moderator | Can kick/ban/unban users from a group. | Local |
| 3 | Governor | Can set rules/motd/link. Can promote/demote moderators. Can modify flags. | Local |
| 4 | Administrator | Can globally ban/unban users. Can promote/demote governors. | Global |
| 5 | Owner | Can add/remove groups. Can broadcast. Can promote/demote administrators. | Global |

Obviously, each greater rank inherits the privileges of the lower, positive ranks.

### Flags

| # | Name | Description |
|:-:|:-----|:------------|
| 1 | unlisted | Removes a group from the /groups listing. |
| 2 | antisquig | Automatically removes users for posting Arabic script or RTL characters. |
| 3 | antisquig Strict | Automatically removes users whose names contain Arabic script or RTL characters. |
| 4 | antibot | Prevents bots from being added by non-moderators. |

* * *

# Liberbot-related plugins {#Liberbot-related_plugins}
**Note:** This section may be out of date. The Liberbot-related plugins have not changed in very long time.
Some plugins are only useful when the bot is used in a Liberbot group, like floodcontrol.lua and moderation.lua.

**floodcontrol.lua** makes the bot compliant with Liberbot's floodcontrol function. When the bot has posted too many messages to a single group in a given period of time, Liberbot will send it a message telling it to cease posting in that group. Here is an example floodcontrol command:
`/floodcontrol {"groupid":987654321,"duration":600}`
The bot will accept these commands from both Liberbot and the configured administrator.

**moderation.lua** allows the owner to use the bot to moderate a Liberbot realm, or set of groups. This works by adding the bot to the realm's admin group and making it an administrator.
You must configure the plugin in the "moderation" section of config.lua, in the following way:
```lua
moderation = {
    admins = {
        ['123456789'] = 'Adam',
        ['246813579'] = 'Eve'
    },
    admin_group = -987654321,
    realm_name = 'My Realm'
}
```

Where Adam and Eve are realm administrators, and their IDs are set as their keys in the form of strings. admin_group is the group ID of the admin group, as a negative number. realm_name is the name of your Libebot realm.

Once this is set up, put your bot in the admin group and run `/modadd` and `/modhelp` to get started.

* * *

## List of plugins {#List_of_plugins}

| Plugin | Command | Function | Aliases |
|:-------|:--------|:---------|:--------|
| help.lua | /help | Returns a list of commands. | /h |
| about.lua | /about | Returns the about text as configured in config.lua. |
| ping.lua | /ping | The simplest plugin ever! |
| echo.lua | /echo <text> | Repeats a string of text. |
| gSearch.lua | /google <query> | Returns Google web results. | /g, /gnsfw |
| gImages.lua | /images <query> | Returns a Google image result. | /i, /insfw |
| gMaps.lua | /location <query> | Returns location data from Google Maps. | /loc |
| youtube.lua | /youtube <query> | Returns the top video result from YouTube. | /yt |
| wikipedia.lua | /wikipedia <query> | Returns the summary of a Wikipedia article. | /wiki |
| lastfm.lua | /np [username] | Returns the song you are currently listening to. |
| lastfm.lua | /fmset [username] | Sets your username for /np. /fmset -- will delete it. |
| hackernews.lua | /hackernews | Returns the latest posts from Hacker News. | /hn |
| imdb.lua | /imdb <query> | Returns film information from IMDb. |
| hearthstone.lua | /hearthstone <query> | Returns data for Hearthstone cards matching the query. | /hs |
| calc.lua | /calc <expression> | Returns solutions to math expressions and conversions between common units. |
| bible.lua | /bible <reference> | Returns a Bible verse. | /b |
| urbandictionary.lua | /urbandictionary <query> | Returns the top definition from Urban Dictionary. | /ud, /urban |
| time.lua | /time <query> | Returns the time, date, and a timezone for a location. |
| weather.lua | /weather <query> | Returns current weather conditions for a given location. |
| nick.lua | /nick <nickname> | Set your nickname. /nick - will delete it. |
| whoami.lua | /whoami | Returns user and chat info for you or the replied-to user. | /who |
| eightball.lua | /8ball | Returns an answer from a magic 8-ball. |
| dice.lua | /roll <nDr> | Returns RNG dice rolls. Uses D&D notation. |
| reddit.lua | /reddit [r/subreddit ¦ query] | Returns the top results from a given subreddit, query, or r/all. | /r |
| xkcd.lua | /xkcd [query] | Returns an xkcd strip and its alt text. |
| slap.lua | /slap <target> | Gives someone a slap (or worse). |
| commit.lua | /commit | Returns a commit message from whatthecommit.com. |
| fortune.lua | /fortune | Returns a UNIX fortune. |
| pun.lua | /pun | Returns a pun. |
| pokedex.lua | /pokedex <query> | Returns a Pokedex entry. | /dex |
| currency.lua | /cash [amount] <currency> to <currency> | Converts one currency to another. |
| cats.lua | /cat | Returns a cat picture. |
| reactions.lua | /reactions | Returns a list of reaction emoticons which can be used through the bot. |
| apod.lua | /apod [date] | Returns the NASA Astronomy Picture of the Day. |
| dilbert.lua | /dilbert [date] | Returns a Dilbert strip. |
| patterns.lua | /s/<from>/<to>/ | Fixed that for you. :^) |

* * *

## Style {#Style}
Bot output from every plugin should follow a consistent style. This style is easily observed interacting with the bot.
Titles should be either **bold** (along with their colons) or a [link](http://otou.to) (with plaintext colons) to the content's source. Names should be _italic_. Numbered lists should use bold numbers followed by a bold period followed by a space. Unnumbered lists should use the • bullet point followed by a space. Descriptions and information should be in plaintext, although "flavor" text should be italic. Technical information should be `monospace`. Links should be named.
