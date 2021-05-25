//
//  BackgroundGradient.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/25/21.
//

import SwiftUI

enum WeatherCondition: String {
	case clearSky = "01"
	case fewClouds = "02"
	case scatteredClouds = "03"
	case brokenClouds = "04"
	case showerRain = "09"
	case rain = "10"
	case thunderstorm = "11"
	case snow = "13"
	case mist = "50"
	
	// MARK: - Add more colors
	var colors: [Color] {
		switch self {
			case .clearSky:
				return [Color("ClearColor1"), Color("ClearColor2")]
			case .fewClouds, .scatteredClouds, .brokenClouds:
				return [Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))]
			case .showerRain, .rain, .thunderstorm:
				return [Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))]
			default:
				return [Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)), Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))]
		}
	}
}

struct BackgroundGradient: View {
	@Binding var type: WeatherCondition
	
	var body: some View {
		LinearGradient(gradient: Gradient(colors: type.colors),
					   startPoint: .top,
					   endPoint: .bottom)
			.ignoresSafeArea()
	}
}
 
