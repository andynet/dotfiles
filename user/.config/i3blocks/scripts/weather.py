#!/bin/python

import requests
import datetime

data = requests.get(
    'https://api.openweathermap.org/data/2.5/forecast/daily?'
    'lat=48.1486&lon=17.1077&cnt=1&units=metric&'
    'appid=85a4e3c55b73909f42c6a23ec35b7147'
).json()
today = data["list"][0]

weather = today["weather"][0]["main"]
min_temp = today["temp"]["min"]
max_temp = today["temp"]["max"]
sunrise = today["sunrise"]
sunset = today["sunset"]

match weather:
    case "Thunderstorm":
        weather = " "  # 
    case "Drizzle":
        weather = " "
    case "Rain":
        weather = " "
    case "Snow":
        weather = " "
    case "Clear":
        weather = " "
    case "Clouds":
        weather = " "

min_temp = int(min_temp)
max_temp = int(max_temp)

sunrise = datetime.datetime.fromtimestamp(sunrise).strftime("%H:%M")
sunset = datetime.datetime.fromtimestamp(sunset).strftime("%H:%M")

print(f"{weather}{min_temp}/{max_temp}°C {sunrise} {sunset}")

# curl 'wttr.in/Bratislava?format=4'
