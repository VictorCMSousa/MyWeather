//
//  Data.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation

extension Data {
    
    static let weatherResponse = Data("""
{
    "lat": -22.9109,
    "lon": -43.2045,
    "timezone": "America/Sao_Paulo",
    "timezone_offset": -10800,
    "current": {
        "dt": 1667667336,
        "sunrise": 1667635520,
        "sunset": 1667682447,
        "temp": 23.1,
        "feels_like": 23.22,
        "pressure": 1018,
        "humidity": 67,
        "dew_point": 16.64,
        "uvi": 7.76,
        "clouds": 40,
        "visibility": 10000,
        "wind_speed": 6.17,
        "wind_deg": 130,
        "weather": [
            {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03d"
            }
        ]
    },
    "daily": [
        {
            "dt": 1667656800,
            "sunrise": 1667635520,
            "sunset": 1667682447,
            "moonrise": 1667673660,
            "moonset": 1667629020,
            "moon_phase": 0.4,
            "temp": {
                "day": 21.79,
                "min": 16.25,
                "max": 23.1,
                "night": 19.08,
                "eve": 21.84,
                "morn": 16.25
            },
            "feels_like": {
                "day": 21.8,
                "night": 18.85,
                "eve": 21.78,
                "morn": 16.28
            },
            "pressure": 1019,
            "humidity": 68,
            "dew_point": 15.63,
            "wind_speed": 3.36,
            "wind_deg": 187,
            "wind_gust": 3.9,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 24,
            "pop": 0.58,
            "rain": 3.73,
            "uvi": 11.7
        },
        {
            "dt": 1667743200,
            "sunrise": 1667721889,
            "sunset": 1667768884,
            "moonrise": 1667763420,
            "moonset": 1667717460,
            "moon_phase": 0.44,
            "temp": {
                "day": 22.7,
                "min": 17.68,
                "max": 22.82,
                "night": 20.12,
                "eve": 21.39,
                "morn": 17.68
            },
            "feels_like": {
                "day": 22.57,
                "night": 19.86,
                "eve": 21.18,
                "morn": 17.51
            },
            "pressure": 1020,
            "humidity": 59,
            "dew_point": 13.97,
            "wind_speed": 3.87,
            "wind_deg": 182,
            "wind_gust": 3.93,
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02d"
                }
            ],
            "clouds": 20,
            "pop": 0.07,
            "uvi": 13.14
        },
        {
            "dt": 1667829600,
            "sunrise": 1667808260,
            "sunset": 1667855321,
            "moonrise": 1667853240,
            "moonset": 1667805900,
            "moon_phase": 0.47,
            "temp": {
                "day": 20.34,
                "min": 18.76,
                "max": 21.6,
                "night": 19.08,
                "eve": 19.23,
                "morn": 18.99
            },
            "feels_like": {
                "day": 20.31,
                "night": 19.11,
                "eve": 19.25,
                "morn": 18.82
            },
            "pressure": 1020,
            "humidity": 72,
            "dew_point": 15.07,
            "wind_speed": 2.58,
            "wind_deg": 198,
            "wind_gust": 2.81,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 87,
            "pop": 0.64,
            "rain": 1.19,
            "uvi": 2.96
        },
        {
            "dt": 1667916000,
            "sunrise": 1667894632,
            "sunset": 1667941759,
            "moonrise": 1667943000,
            "moonset": 1667894520,
            "moon_phase": 0.5,
            "temp": {
                "day": 21.77,
                "min": 18.29,
                "max": 22.38,
                "night": 18.96,
                "eve": 19.54,
                "morn": 18.29
            },
            "feels_like": {
                "day": 21.86,
                "night": 19.34,
                "eve": 19.69,
                "morn": 18.37
            },
            "pressure": 1019,
            "humidity": 71,
            "dew_point": 16.14,
            "wind_speed": 2.74,
            "wind_deg": 171,
            "wind_gust": 3.58,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 96,
            "pop": 0.72,
            "rain": 2.22,
            "uvi": 9.3
        },
        {
            "dt": 1668002400,
            "sunrise": 1667981005,
            "sunset": 1668028197,
            "moonrise": 1668032880,
            "moonset": 1667983260,
            "moon_phase": 0.54,
            "temp": {
                "day": 23.71,
                "min": 18.81,
                "max": 23.71,
                "night": 19.79,
                "eve": 20.58,
                "morn": 18.81
            },
            "feels_like": {
                "day": 24.04,
                "night": 20.36,
                "eve": 21.04,
                "morn": 19.17
            },
            "pressure": 1018,
            "humidity": 73,
            "dew_point": 18.32,
            "wind_speed": 3.47,
            "wind_deg": 170,
            "wind_gust": 4.2,
            "weather": [
                {
                    "id": 501,
                    "main": "Rain",
                    "description": "moderate rain",
                    "icon": "10d"
                }
            ],
            "clouds": 85,
            "pop": 1,
            "rain": 18.13,
            "uvi": 4.17
        },
        {
            "dt": 1668088800,
            "sunrise": 1668067379,
            "sunset": 1668114635,
            "moonrise": 1668122640,
            "moonset": 1668072120,
            "moon_phase": 0.57,
            "temp": {
                "day": 25.02,
                "min": 19.85,
                "max": 25.02,
                "night": 21.83,
                "eve": 22.11,
                "morn": 19.92
            },
            "feels_like": {
                "day": 25.48,
                "night": 22.42,
                "eve": 22.67,
                "morn": 20.4
            },
            "pressure": 1015,
            "humidity": 73,
            "dew_point": 19.4,
            "wind_speed": 4.09,
            "wind_deg": 184,
            "wind_gust": 5.22,
            "weather": [
                {
                    "id": 501,
                    "main": "Rain",
                    "description": "moderate rain",
                    "icon": "10d"
                }
            ],
            "clouds": 23,
            "pop": 0.95,
            "rain": 4.27,
            "uvi": 5
        },
        {
            "dt": 1668175200,
            "sunrise": 1668153754,
            "sunset": 1668201074,
            "moonrise": 1668212340,
            "moonset": 1668161340,
            "moon_phase": 0.6,
            "temp": {
                "day": 25.68,
                "min": 20.84,
                "max": 25.68,
                "night": 22.45,
                "eve": 22.95,
                "morn": 21
            },
            "feels_like": {
                "day": 26.13,
                "night": 23.1,
                "eve": 23.49,
                "morn": 21.51
            },
            "pressure": 1013,
            "humidity": 70,
            "dew_point": 19.44,
            "wind_speed": 4.15,
            "wind_deg": 130,
            "wind_gust": 6.8,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 65,
            "pop": 0.48,
            "rain": 0.51,
            "uvi": 5
        },
        {
            "dt": 1668261600,
            "sunrise": 1668240131,
            "sunset": 1668287513,
            "moonrise": 1668301860,
            "moonset": 1668250740,
            "moon_phase": 0.63,
            "temp": {
                "day": 23.76,
                "min": 21.15,
                "max": 25.21,
                "night": 22.22,
                "eve": 22.63,
                "morn": 21.15
            },
            "feels_like": {
                "day": 24.46,
                "night": 22.98,
                "eve": 23.4,
                "morn": 21.83
            },
            "pressure": 1011,
            "humidity": 87,
            "dew_point": 21.36,
            "wind_speed": 3.97,
            "wind_deg": 47,
            "wind_gust": 6.5,
            "weather": [
                {
                    "id": 502,
                    "main": "Rain",
                    "description": "heavy intensity rain",
                    "icon": "10d"
                }
            ],
            "clouds": 100,
            "pop": 0.87,
            "rain": 23.4,
            "uvi": 5
        }
    ]
}
""".utf8)
    
    static let anyCityResponse = Data("""
[
    {
        "name": "Chicago",
        "local_names": {
            "zh": "芝加哥",
            "so": "Chicago",
            "ko": "시카고",
            "ky": "Чикаго",
            "eu": "Chicago",
            "tg": "Чикаго",
            "hu": "Chicago",
            "uk": "Чикаго",
            "mr": "शिकागो",
            "br": "Chicago",
            "ha": "Chicago",
            "vo": "Chicago",
            "ne": "शिकागो",
            "bi": "Chicago",
            "el": "Σικάγο",
            "no": "Chicago",
            "sw": "Chicago",
            "rn": "Chicago",
            "nv": "Shikááʼgóó",
            "is": "Chicago",
            "ta": "சிகாகோ",
            "fy": "Chicago",
            "yi": "שיקאגא",
            "id": "Chicago",
            "gd": "Chicago",
            "kk": "Чикаго",
            "sc": "Chicago",
            "li": "Chicago",
            "be": "Чыкага",
            "it": "Chicago",
            "ar": "شيكاغو",
            "cs": "Chicago",
            "en": "Chicago",
            "st": "Chicago",
            "bm": "Chicago",
            "bg": "Чикаго",
            "ku": "Chicago",
            "mi": "Chicago",
            "tr": "Şikago",
            "tl": "Chicago",
            "ml": "ഷിക്കാഗോ",
            "ie": "Chicago",
            "kn": "ಶಿಕಾಗೊ",
            "la": "Sicagum",
            "hi": "शिकागो",
            "ur": "شکاگو، الینوائے",
            "co": "Chicago",
            "kl": "Chicago",
            "pa": "ਸ਼ਿਕਾਗੋ",
            "ig": "Chicago",
            "de": "Chicago",
            "fj": "Chicago",
            "lv": "Čikāga",
            "ro": "Chicago",
            "nn": "Chicago",
            "gv": "Chicago",
            "ia": "Chicago",
            "sq": "Çikago",
            "sh": "Chicago",
            "bn": "শিকাগো",
            "ka": "ჩიკაგო",
            "sn": "Chicago",
            "qu": "Chicago",
            "bh": "शिकागो",
            "th": "ชิคาโก",
            "tw": "Kyekago",
            "hy": "Չիկագո",
            "pl": "Chicago",
            "sl": "Chicago",
            "ga": "Chicago",
            "kw": "Chicago",
            "tt": "Çikago",
            "an": "Chicago",
            "ms": "Chicago",
            "pt": "Chicago",
            "ru": "Чикаго",
            "es": "Chicago",
            "lb": "Chicago",
            "gn": "Chikago",
            "gl": "Chicago",
            "rm": "Chicago",
            "jv": "Chicago",
            "os": "Чикаго",
            "fr": "Chicago",
            "fa": "شیکاگو",
            "am": "ሺካጎ",
            "ak": "Chicago",
            "hr": "Chicago",
            "et": "Chicago",
            "se": "Chicago",
            "fo": "Chicago",
            "cy": "Chicago",
            "na": "Chicago",
            "zu": "Chicago",
            "io": "Chicago",
            "sv": "Chicago",
            "sg": "Chicago",
            "ug": "Chikago",
            "iu": "ᓰᖄᑯ",
            "ps": "شیکاګو",
            "ca": "Chicago",
            "ja": "シカゴ",
            "lt": "Čikaga",
            "wa": "Tchicago",
            "te": "చికాగో",
            "ht": "Chikago",
            "sr": "Чикаго",
            "vi": "Chicago",
            "af": "Chicago",
            "bs": "Chicago",
            "nl": "Chicago",
            "fi": "Chicago",
            "uz": "Chicago",
            "mg": "Chicago",
            "az": "Çikaqo",
            "sk": "Chicago",
            "ce": "Чикаго",
            "my": "ရှီကာဂိုမြို့",
            "he": "שיקגו",
            "da": "Chicago",
            "eo": "Ĉikago",
            "oc": "Chicago",
            "mk": "Чикаго",
            "tk": "Chicago",
            "ki": "Chicago",
            "mn": "Чикаго",
            "yo": "Ṣìkágò",
            "xh": "E-Chicago"
        },
        "lat": 41.8755616,
        "lon": -87.6244212,
        "country": "US",
        "state": "Illinois"
    },
    {
        "name": "Chicago",
        "lat": -33.71745,
        "lon": 18.9963167,
        "country": "ZA",
        "state": "Western Cape"
    },
    {
        "name": "Chicago",
        "lat": -18.9535788,
        "lon": 29.7953081,
        "country": "ZW",
        "state": "Midlands Province"
    },
    {
        "name": "Chicago",
        "lat": 4.9324371,
        "lon": -52.331324,
        "country": "FR",
        "state": "French Guiana"
    },
    {
        "name": "Chicago",
        "lat": 18.4172472,
        "lon": -68.9756563,
        "country": "DO",
        "state": "La Romana"
    }
]
""".utf8)
}
