//
//  Weather.swift
//  Weather
//
//  Created by John Schils on 6/12/21.
//

import Foundation

struct Week: Decodable {
    var current: CurrentDay
    var daily: [Day]
}

struct CurrentDay: Decodable {
    var dt: Double?
    var temp: Double?
    var weather: [Weather]
}

struct Day: Decodable {
    var dt: Double?
    var sunrise: Int?
    var sunset: Int?
    var temp: Temp
    var weather: [Weather]
}

struct Temp: Decodable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
}

struct Weather: Decodable {
    var main: String?
    var description: String?
}
