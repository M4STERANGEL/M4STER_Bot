# M4STER_Bot
Bot desarrollado por [@M4STER_ANGEL](http://telegram.me/m4ster_angel) para Telegram con una API basada en .lua

#Instalación
1 <b>Instalar librerías</b>
```bash
sudo apt-get update
sudo apt-get install lua5.2
sudo apt-get install lua-sec
sudo apt-get install lua-socket
sudo apt-get install lua-cjson
```

2 <b>Clonar el repositorio</b>
```bash
git clone https://github.com/M4STERANGEL/M4STER_Bot.git
cd M*
chmod +x launch.sh
```

3 <b>Configurar el bot</b>
```
Tendrás que configurar el archivo config.lua, en donde pone bot_api_key, tu token que te dió el BotFather
```

4 <b>Iniciar el bot</b>
```bash
./launch.sh
```

5 (Opcional) Actualizar el repositorio
```bash
git pull
```

#Configuración Inicial
<b>Tendrás que configurar, en el archivo config.lua:</b><br><br>
`admin` - Tu ID de Telegram<br>
`admin_name` - Como quieres que te llame el bot<br>
`time_offset` - Un número positivo/negativo que indique tu diferencia horaria con respecto al UTC<br>
`lang` - Idioma del Bot (en, es...)

#Configuración Extra
Si quieres configurar más cosas, como las <b>APis</b> o personalizarlo más, tendrás que mirar el archivo [funciones.md](https://github.com/M4STERANGEL/M4STER_Bot/FUNCIONES.md)

* * *

#Bot Original
<b>Esto es una versión adaptada de otro bot</b>

El bot original es: otouto <br>
[![https://github.com/topkecleon/otouto](https://img.shields.io/badge/Original-otouto-yellow.svg)](https://github.com/topkecleon/otouto)
