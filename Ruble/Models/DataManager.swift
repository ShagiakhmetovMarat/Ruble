//
//  DataManager.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 04.05.2023.
//

import UIKit

struct DataManager {
    static let shared = DataManager()
    
    let flag = ["armenia", "australia", "azerbaijan", "belarus", "brazil",
                "bulgaria", "canada", "china", "czech", "denmark", "euro",
                "great britain", "hong kong", "hungary", "india", "japan",
                "kazakhstan", "kyrgyzstan", "moldova", "norway", "poland",
                "romania", "russia", "singapore", "south africa", "south korea",
                "sweden", "switzerland", "tajikistan", "turkey", "turkmenistan",
                "ukraine", "usa", "uzbekistan", "vietnam", "georgia", "uae",
                "egypt", "indonesia", "qatar", "new zealand", "thailand",
                "serbia"]
    
    let charCode = ["AMD", "AUD", "AZN", "BYN", "BRL", "BGN", "CAD", "CNY",
                    "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "INR", "JPY",
                    "KZT", "KGS", "MDL", "NOK", "PLN", "RON", "RUB", "SGD",
                    "ZAR", "KRW", "SEK", "CHF", "TJS", "TRY", "TMT", "UAH",
                    "USD", "UZS", "VND", "GEL", "AED", "EGP", "IDR", "QAR",
                    "NZD", "THB", "RSD"]
    
    let name = ["Armenian dram", "Australian dollar", "Azerbaijani manat",
                "Belarusian ruble", "Brazilian real", "Bulgarian lev",
                "Canadian dollar", "Chinese yuan", "Czech koruna",
                "Danish krone", "Euro", "British pound", "Hong Kong dollar",
                "Hungarian forint", "Indian rupee", "Japanese yen",
                "Kazakhstani tenge", "Kyrgyz som",
                "Moldovan leu", "Norwegian krone", "Polish zloty",
                "Romanian leu", "Russian ruble", "Singapore dollar",
                "South Africa rand", "South Korean won", "Swedish krona",
                "Swiss franc", "Tajik somoni", "Turkish lira",
                "Turkmen manat", "Ukrainian hryvnia", "US dollar", "Uzbek sum",
                "Vietnamese dong", "Georgian lari", "UAE dirham", "Egyptian pound",
                "Indonesian rupiah", "Qatari riyal", "New Zealand dollar",
                "Thai baht", "Serbian dinar"]
    /*
    let name = ["Армянский драм", "Австралийский доллар", "Азербайджанский манат",
                "Беларусский рубль", "Бразильский реал", "Болгарский лев",
                "Канадский доллар", "Китайский юань", "Чешская крона",
                "Датская крона", "Евро", "Английский фунт", "Гонконгский доллар",
                "Венгерский форинт", "Индийская рупия", "Японская иена",
                "Казахстанский тенге", "Киргизский сом",
                "Молдавский лей", "Новержская крона", "Польский злотый",
                "Румынский лей", "Российский рубль", "Сингапурский доллар",
                "Южноафриканский рэнд", "Южнокорейская вона", "Шведская крона",
                "Швейцарский франк", "Таджикский сомони", "Турецкая лира",
                "Туркменский манат", "Украинская гривна", "Доллар США",
                "Узбекский сум"]
    */
    private init() {}
}
