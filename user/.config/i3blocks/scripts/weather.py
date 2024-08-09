#!/bin/python

import requests
from datetime import datetime as dt


def weather_icon(weather: str) -> str:
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
    return weather


data = requests.get(
    'https://api.openweathermap.org/data/2.5/forecast/daily?'
    'lat=48.1486&lon=17.1077&cnt=2&units=metric&'
    'appid=85a4e3c55b73909f42c6a23ec35b7147'
).json()
today = data["list"][0]
tomorrow = data["list"][1]

sunmoves = [
    today["sunrise"], today["sunset"], tomorrow["sunrise"], tomorrow["sunset"]
]
current_time = dt.now().timestamp()

i = 0  # possible values are 0, 1, 2 with explanations in the if statement
while sunmoves[i] < current_time:
    i += 1

if i == 2:  # after today's sunset
    weather = weather_icon(tomorrow["weather"][0]["main"])
    min_temp = int(tomorrow["temp"]["min"])
    max_temp = int(tomorrow["temp"]["max"])
    sunsign1 = ""
    sunmove1 = dt.fromtimestamp(tomorrow["sunrise"]).strftime("%H:%M")
    sunsign2 = ""
    sunmove2 = dt.fromtimestamp(tomorrow["sunset"]).strftime("%H:%M")
    line = "{}{}/{}°C·{}{} {}{}"
elif i == 1:  # during the day
    weather = weather_icon(today["weather"][0]["main"])
    min_temp = int(today["temp"]["min"])
    max_temp = int(today["temp"]["max"])
    sunsign1 = ""
    sunmove1 = dt.fromtimestamp(today["sunset"]).strftime("%H:%M")
    sunsign2 = ""
    sunmove2 = dt.fromtimestamp(tomorrow["sunrise"]).strftime("%H:%M")
    line = "{}{}/{}°C {}{}·{}{}"
else:  # before today's sunrise
    weather = weather_icon(today["weather"][0]["main"])
    min_temp = int(today["temp"]["min"])
    max_temp = int(today["temp"]["max"])
    sunsign1 = ""
    sunmove1 = dt.fromtimestamp(today["sunrise"]).strftime("%H:%M")
    sunsign2 = ""
    sunmove2 = dt.fromtimestamp(today["sunset"]).strftime("%H:%M")
    line = "{}{}/{}°C {}{} {}{}"

print(line.format(
    weather, min_temp, max_temp, sunsign1, sunmove1, sunsign2, sunmove2
))

# curl 'wttr.in/Bratislava?format=4'
