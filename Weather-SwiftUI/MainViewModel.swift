//
//  MainViewModel.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/24/21.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
	@Published var type: WeatherCondition = .clearSky
	@Published var cityName: String = UserDefaults.standard.string(forKey: "cityName") ?? ""
	@Published var degrees: String = "0"
	@Published var humidity: String = "0"
	@Published var visibility: String = "0"
	@Published var pressure: String = "0"
	@Published var iconURL: URL?
	@Published var mainTitle: String = "Weather"
	@Published var descriptionTitle: String = "Weather"
	@Published var alertMessage: String = ""
	@Published var showAlert: Bool = false
	@Published var imageShown = false
	
	private var cancellationToken: AnyCancellable?
	
	init() {
		getWeather()
	}
	
	func getWeather() {
		cancellationToken = WeatherAPI.request(.city)
			.mapError({ (error) -> Error in
				self.alertMessage = error.localizedDescription
				self.showAlert = true
				return error
			})
			.sink(receiveCompletion: { _ in },
				  receiveValue: {
					self.cityName = $0.name
					self.updateDegrees(Int($0.main.temp))
					self.humidity = "\($0.main.humidity)"
					self.visibility = String($0.visibility)
					self.pressure = "\($0.main.pressure)"
					let iconName = $0.weather.first?.icon ?? ""
					self.setType(iconName)
					self.iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
					self.mainTitle = $0.weather.first?.main ?? ""
					self.descriptionTitle = $0.weather.first?.description ?? ""
				  })
	}
	
	func updateDegrees(_ degrees: Int) {
		var counter = 1
		
		// MARK: - Need to add negative values too
		Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
			counter += 1
			self.degrees = String(counter)
			if counter == degrees {
				timer.invalidate()
			}
		}
	}
	
	func setType(_ iconName: String) {
		guard !iconName.isEmpty else { return }
		self.imageShown = true
		let result = iconName.filter("0123456789.".contains)
		self.type = WeatherCondition(rawValue: result) ?? .clearSky
	}
	
	func setNewCity(_ text: String) {
		UserDefaults.standard.set(text, forKey: "cityName")
		self.cityName = text
		self.imageShown = false
		getWeather()
	}
}
