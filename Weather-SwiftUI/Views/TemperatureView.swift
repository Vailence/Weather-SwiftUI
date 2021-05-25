//
//  TemperatureView.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/25/21.
//

import SwiftUI

struct TemperatureView: View {
	@Binding var degrees: String
	
	var body: some View {
		HStack {
			Text(degrees)
				.font(.system(size: 100,
							  weight: .bold))
				.textCase(.uppercase)
				.foregroundColor(.white)
			VStack(alignment: .leading) {
				Image(systemName: "circle")
					.resizable()
					.font(.system(size: 25, weight: .bold))
					.frame(width: 15, height: 15)
					.foregroundColor(.white)
				Spacer()
			}
			Spacer()
		}
		.frame(width: 250, height: 90)
	}
}
