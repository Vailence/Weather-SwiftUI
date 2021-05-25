//
//  WeatherResponse.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/24/21.
//

import Foundation

struct WeatherResponse: Codable {
	let coordinates: Coordinates
	let weather: [Weather]
	let base: String
	let main: Main
	let visibility: Int
	let id: Int
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case coordinates = "coord"
		case weather, base, id, name, main, visibility
	}
}

struct Coordinates: Codable {
	let lon: Double
	let lat: Double
}

struct Weather: Codable {
	let id: Int
	let main: String
	let description: String
	let icon: String
}

struct Main: Codable {
	let temp, feelsLike, tempMin, tempMax: Double
	let pressure, humidity: Int
	let seaLevel, grndLevel: Int?

	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure, humidity
		case seaLevel = "sea_level"
		case grndLevel = "grnd_level"
	}
}
