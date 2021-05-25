//
//  WeatherAPI.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/24/21.
//

import Foundation
import Combine

enum WeatherAPI {
	static let apiClient = APIClient()
	static let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/")!
}

enum APIPath: String {
	case city = "weather"
}

extension WeatherAPI {
	static func request(_ path: APIPath) -> AnyPublisher<WeatherResponse, Error> {
		// 3
		guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
			else { fatalError("Couldn't create URLComponents") }
		let cityName = UserDefaults.standard.string(forKey: "cityName") ?? "Almaty"
		components.queryItems = [.init(name: "q", value: cityName),
								 .init(name: "appid", value: "1512bba57fb77004ff1adf781fb7be58"),
								 .init(name: "units", value: "metric")]
		
		let request = URLRequest(url: components.url!)
		
		return apiClient.run(request) // 5
			.map(\.value) // 6
			.eraseToAnyPublisher() // 7
	}
}
