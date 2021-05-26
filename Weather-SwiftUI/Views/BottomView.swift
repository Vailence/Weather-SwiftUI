//
//  BottomView.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/25/21.
//

import SwiftUI

struct BottomView: View {
	@Binding var humidity: String
	@Binding var visibility: String
	@Binding var pressure: String
	
	var body: some View {
		HStack(spacing: 16) {
			BottomViewRow(text: .constant(humidity), description: "Humidity")
			DividerView()
			BottomViewRow(text: .constant(visibility), description: "Visibility")
			DividerView()
			BottomViewRow(text: .constant(pressure), description: "Pressure")
		}
		.frame(maxWidth: .infinity)
		.frame(height: 70)
		.background(
			Color.white
				.cornerRadius(16)
				.opacity(0.1)
		)
		.overlay(
			RoundedRectangle(cornerRadius: 16)
				.stroke(Color.white, lineWidth: 2)
		)
	}
}

struct BottomViewRow: View {
	@Binding var text: String
	@State var description: String
	
	var body: some View {
		VStack(alignment: .center, spacing: 8) {
			Text(text)
				.font(.title3)
				.fontWeight(.semibold)
				.foregroundColor(.white)
			Text(description)
				.font(.footnote)
				.foregroundColor(.white)
		}
	}
}

struct DividerView: View {
	var body: some View {
		Rectangle()
			.frame(width: 1, height: 25)
			.foregroundColor(Color.white.opacity(0.3))
	}
}
