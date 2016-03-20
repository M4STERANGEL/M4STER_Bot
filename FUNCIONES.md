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

#Descripción de Privilegios

| # | Nombre | Descripción | Rango |
|:-:|:------|:------------|:------|
| 0 | Baneado | No puede entrar a grupos | Todo |
| 1 | Usuario | Rango predeerminado | Local |
| 2 | Moderador | Puede expulsar y banear a usuarios de los grupos | Local |
| 3 | Governador | Puede administrar al 100% los grupos. Puede promover moderadores | Local |
| 4 | Administrador | Puede banear globalmente a usuarios y promover governadores | Global |
| 5 | Propietario | Puede añador grupos. Puede promover administradores | Global |

Obviamente, los rangos superiores pueden hacer lo que los inferiores

#Reglas

| # | Nombre | Descripción |
|:-:|:-----|:------------|
| 1 | unlisted | Elimina al grupo de la lista de grupos públicos |
| 2 | antisquig | Elimina al usuario que postea con carácteres árabes |
| 3 | antisquig Strict | Elimina a los usuarios con carácteres árabes en sus nombres |
| 4 | antibot | Bloquea a los bots de los grupos |

* * *

#Liberbot {Plugins relacionados con Liberbot}
**Note:** Seguramente está sección esté desactualziada. Los plugins de liberbot están muy desactualizados.
Algunos plugins están basados en los grupos de Liberbot, como floodcontrol.lua y moderation.lua.

**floodcontrol.lua** hace al bot compatible con las funciones de control del flood de Liberbot. Cuando un usuario postea demasiado en un grupo, Liberbot le enviará un mensaje diciendole que deje de postear. Ejemplo:
`/floodcontrol {"groupid":987654321,"duration":600}`
El bot aceptará este comando de LIberbot.

**moderation.lua** permite al usuario moderar un grupo. Funciona añadiendo el bot al grupo de Liberbot y haciéndolo admin.
Tendrás que configurar el config.lua de la siguiente manera:
```lua
moderation = {
    admins = {
        ['Un ID'] = 'Un nombre',
        ['Otro ID'] = 'Otro Nombre'
    },
    admin_group = -(ID del grupo),
    realm_name = 'Nombre del grupo'
}
```

Cuando se han configurado los admins, ellos tendrán control sobre el bot. 
admin_group es el ID del grupo de administración, con un número negativo
realm_name es el nombre del grupo de administración

Cuando todo esto está listo, ejecuta `/modadd` y `/modhelp` para comenzar.

* * *

#Lista de plugins

| Plugin | Comando | Funcción | Alias |
|:-------|:--------|:---------|:--------|
| help.lua | /help | Comando de ayuda | /h |
| about.lua | /about | Da una información que se aloja en el archivo config.lua |
| ping.lua | /ping | El plugin más simple de todos |
| echo.lua | /echo <texto> | Repite un cacho de textoo |
| gSearch.lua | /google <consulta> | Busca en Google | /g, /gnsfw |
| gImages.lua | /images <consulta> | Busca una imagen en Google | /i, /insfw |
| gMaps.lua | /location <consulta> | Busca un lugar en  Google Maps. | /loc |
| youtube.lua | /youtube <consulta> | Da el video más visto de Youtu | /yt |
| wikipedia.lua | /wikipedia <consulta> | Da el articulo wikipedia | /wiki |
| lastfm.lua | /np [username] | Da la canción que estabas escuchando |
| lastfm.lua | /fmset [username] | Elige el usuario fijo para /np. /fmset -- lo eliminará |
| hackernews.lua | /hackernews | Da las ultimas noticias de hackernews | /hn |
| imdb.lua | /imdb <consulta> | Da la información de la peli de IMDb |
| hearthstone.lua | /hearthstone <consulta> | Da la información de la carta de HearthStone | /hs |
| calc.lua | /calc <expresión> | Una calculadora |
| bible.lua | /bible <referencia> | Da el verso de la biblia | /b |
| urbandictionary.lua | /urbandictionary <consulta> | Da la definición en el diccionario | /ud, /urban |
| time.lua | /time <consulta> | Da la información temporal de esa localización |
| weather.lua | /weather <consulta> | Da el tiempo concreto de esa localización |
| nick.lua | /nick <nickname> | Elige como quieres que el bot te llame /nick - lo eliminará. |
| whoami.lua | /whoami | Da la información de ese usuario | /who |
| eightball.lua | /8ball | Responde a tu pregunta con 8-ball. |
| dice.lua | /roll <nDr> | Da dados RNG. Usa la notación D&D |
| reddit.lua | /reddit [r/subreddit ¦ consulta] | Utilidades de reddit | /r |
| xkcd.lua | /xkcd [consulta] | Da una tira de comic |
| slap.lua | /slap <target> | Da una torta (oo algo peor) |
| commit.lua | /commit | Da un mensaje aleatorio |
| fortune.lua | /fortune | Da una ruleta de la fortuna UNIX |
| pun.lua | /pun | Da un juego de palabras |
| pokedex.lua | /pokedex <consulta> | Da una entrada de la pokedex | /dex |
| currency.lua | /cash [amount] <currency> to <currency> | Convierte una moneda en otra |
| cats.lua | /cat | Da una foto de un gatito |
| reactions.lua | /reactions | Da una lista de emoticonos especiales del bot |
| apod.lua | /apod [date] | Da la imagen del dia de la NASA |
| dilbert.lua | /dilbert [date] | Da una tira dilbert |
| patterns.lua | /s/<from>/<to>/ | Arreglo algo para ti |

* * *

#Estilo
Las respuestas del bot mantienen siempre un patrón de estilo. Es muy facil de observar al interactuar con el bot.
Los títulos se escriben con **bold** o un [link](http://m4ster-angel.tk) a una fuente concreta. Los nombres estarán en _italica_. Las listas numeradas deben utilizar los números en negrilla seguido de un período negrita seguido de un espacio. Las listas no numeradas usan los puntos • seguidos de un espacio. Las descripciones e información deben estar en texto sin formato, excepto el texto "con sabor" que debe estar en cursiva. Información técnica debe estar en `monospace`. Los links deberán estar nombrados.
