%dw 2.0
output application/json  


var weatherMapping = readUrl("classpath://WeatherCode.csv", "application/csv")

fun weatherFunction(code) =
    (weatherMapping filter ($.source1 as Number == code))[0].target default "Inconnu"

var weathers = [payload]
---
weathers map (location) -> {
  coordinates: {
    latitude: location.latitude,
    longitude: location.longitude
  },
  forecast: location.daily.time map ((date, index) -> {
    date: date,
    temperature: {
      min: (location.daily.temperature_2m_min[index]) as String default "Non disponible",
      max: (location.daily.temperature_2m_max[index]) as String default "Non disponible"
    },
    weather: weatherFunction(location.daily.weather_code[index])
  })
}