%dw 2.0
output application/json  

fun mapWeather(code) =
  code match {
    case 0 -> "Clear sky"
    case 1 -> "Mainly clear"
    case 2 -> "Partly cloudy"
    case 3 -> "Overcast"
    case 45 -> "Fog"
    case 48 -> "Depositing rime fog"
    case 51 -> "Drizzle: light intensity"
    case 53 -> "Drizzle: moderate intensity"
    case 55 -> "Drizzle: dense intensity"
    case 56 -> "Freezing Drizzle: light density"
    case 57 -> "Freezing Drizzle: dense density"
    case 61 -> "Rain: slight intensity"
    case 63 -> "Rain: moderate intensity"
    case 65 -> "Rain: heavy intensity"
    case 66 -> "Freezing Rain: light intensity"
    case 67 -> "Freezing Rain: heavy intensity"
    case 71 -> "Snow fall: slight intensity"
    case 73 -> "Snow fall: moderate intensity"
    case 75 -> "Snow fall: heavy intensity"
    case 77 -> "Snow grains"
    case 80 -> "Rain showers: slight"
    case 81 -> "Rain showers: moderate"
    case 82 -> "Rain showers: violent"
    case 85 -> "Snow showers slight"
    case 86 -> "Snow showers heavy"
    case 95 -> "Thunderstorm: Slight"
    case 96 -> "Thunderstorm with slight hail"
    case 99 -> "Thunderstorm with heavy hail"
    else -> "Unknown"
  }

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
      min: (location.daily.temperature_2m_min[index]) as String,
      max: (location.daily.temperature_2m_max[index]) as String
    },
    weather: mapWeather(location.daily.weather_code[index])
  })
}