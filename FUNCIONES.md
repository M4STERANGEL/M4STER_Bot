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
The administration plugin enables self-hosted, single-realm group administration, supporting both normal groups and supergroups. This works by sending TCP commands to an instance of tg running on the owner's account.

To get started, run `./tg-install.sh`. Note that this script is written for Ubuntu/Debian. If you're running Arch (the only acceptable alternative), you'll have to do it yourself. If that is the case, note that otouto uses the "test" branch of tg, and the AUR package `telegram-cli-git` will not be sufficient, as it does not have support for supergroups yet.

Once the installation is finished, enable `administration.lua` in your config file. You may have reason to change the default TCP port (4567); if that is the case, remember to change it in `tg-launch.sh` as well. Run `./tg-launch.sh` in a separate screen/tmux window. You'll have to enter your phone number and go through the login process the first time. The script is set to restart tg after two seconds, so you'll need to Ctrl+C after exiting.

While tg is running, you may start/reload otouto with administration.lua enabled, and have access to a wide variety of administrative commands and automata. The administration "database" is stored in `administration.json`. To start using otouto to administrate a group (note that you must be the owner (or an administrator)), send `/gadd` to that group. For a list of commands, use `/ahelp`. Below I'll describe various functions now available to you.

| Command | Function | Privilege | Internal? |
|:--------|:---------|:----------|:----------|
| /groups | Returns a list of administrated groups (except those flagged "unlisted". | 1 | N |
| /ahelp | Returns a list of administrative commands and their required privileges. | 1 | Y |
| /ops | Returns a list of moderators, governors, and administrators. | 1 | Y |
| /desc | Returns the link, rules, MOTD, and enabled flags of a group. | 1 | Y |
| /rules | Returns the rules of a group. | 1 | Y |
| /motd | Returns a group's "Message of the Day". | 1 | Y |
| /link | Returns the link for a group. | 1 | Y |
| /leave | Removes the user from the group. | 1 | Y |
| /kick | Removes the target from the group. | 2 | Y |
| /ban | Bans the target from the group. | 2 | Y |
| /unban | Unbans the target from the group. | 2 | Y |
| /changerule | Changes an individual group rule. | 3 | Y |
| /setrules | Sets the rules for a group. | 3 | Y |
| /setmotd | Sets a group's "Message of the Day". | 3 | Y |
| /setlink | Sets a group's link. | 3 | Y |
| /flag | Returns a list of available flags and their settings, or toggles a flag. | 3 | Y |
| /mod | Promotes a user to a moderator. | 3 | Y |
| /demod | Demotes a moderator to a user. | 3 | Y |
| /gov | Promotes a user to a governor. | 4 | Y |
| /degov | Demotes a governor to a user. | 4 | Y |
| /hammer | Bans a user globally, and blacklists him. | 4 | N |
| /unhammer | Removes a user's global ban, and unblacklists him. | 4 | N |
| /admin | Promotes a user to an administrator. | 5 | N |
| /deadmin | Demotes an administrator to a user. | 5 | N |
| /gadd | Adds a group to the administrative system. | 5 | N |
| /grem | Removes a group from the administrative system | 5 | Y |
| /broadcast | Broadcasts a message to all administrated groups. | 5 | N |

Internal commands can only be run within an administrated group.

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

## Contributors {#Contributors}
Everybody is free to contribute to otouto. If you are interested, you are invited to fork the [repo](http://github.com/topkecleon/otouto) and start making pull requests.. If you have an idea and you are not sure how to implement it, open an issue or bring it up in the Bot Development group.

The creator and maintainer of otouto is [topkecleon](http://github.com/topkecleon). He can be contacted via [Telegram](http://telegram.me/topkecleon), [Twitter](http://twitter.com/topkecleon), or [email](mailto:drew@otou.to).

There are a a few ways to contribute if you are not a programmer. For one, your feedback is always appreciated. Drop me a line on Telegram or on Twitter. Secondly, we are always looking for new ideas for plugins. Most new plugins start with community input. Feel free to suggest them on Github or in the Bot Dev group. You can also donate Bitcoin to the following address:
`1BxegZJ73hPu218UrtiY8druC7LwLr82gS`

Contributions are appreciated in any form. Monetary contributions will go toward server costs. Both programmers and donators will be eternally honored (at their discretion) on this page.

| Contributors |
|:-----------|
| [Juan Potato](http://github.com/JuanPotato) |
| [Tiago Danin](http://github.com/TiagoDanin) |
| [bb010g](http://github.com/bb010g) |
| [Ender](http://github.com/luksireiku) |
| [Iman Daneshi](http://github.com/Imandaneshi) |
| [HeitorPB](http://github.com/heitorPB) |
| [Akronix](http://github.com/Akronix) |
| [Ville](http://github.com/cwxda) |
| [dogtopus](http://github.com/dogtopus) |

| Donators |
|:---------|
| [n8](http://telegram.me/n8_c00) |
| [Alex](http://telegram.me/sandu) |
| [Brayden Banks](http://telegram.me/bb010g) |
