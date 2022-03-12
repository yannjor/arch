#!/bin/sh

get_icon() {
    case $1 in
        # Icons
        01d) icon="" ;; # Clear sky day.
        01n) icon="" ;; # Clear sky night.
        02d) icon="" ;; # Few clouds day.
        02n) icon="" ;; # Few clouds night.
        03d) icon="" ;; # Scattered clouds day.
        03n) icon="" ;; # Scattered clouds night.
        04d) icon="" ;; # Broken clouds day.
        04n) icon="" ;; # Broken clouds night.
        09d) icon="" ;; # Shower rain day.
        09n) icon="" ;; # Shower rain night.
        10d) icon="" ;; # Rain day.
        10n) icon="" ;; # Rain night
        11d) icon="" ;; # Thunderstorm day.
        11n) icon="" ;; # Thunderstorm night
        13d) icon="ﰕ" ;; # Snow day. Snowflake alternative: 
        13n) icon="ﰕ" ;; # Snow night. Snowflake alternative: 
        50d) icon="" ;; # Mist day.
        50n) icon="" ;; # Mist night.ather-icons
        *) icon="" ;;
    esac

    echo "$icon"
}

KEY=""
CITY="Hengelo,NL"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2> /dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
    printf "%s  %s%s" "$(get_icon "$weather_icon")" "$weather_temp" "$SYMBOL"
fi
