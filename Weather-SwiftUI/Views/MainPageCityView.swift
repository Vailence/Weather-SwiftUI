//
//  MainPageCityView.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/25/21.
//

import SwiftUI

struct CityView: View {
	@Binding var title: String
	@Binding var isEditing: Bool
	@Binding var searchText: String
	
	var action: (String) -> Void?
	
	var body: some View {
		if isEditing {
			TextField("Search...", text: $searchText, onCommit: {
				action(searchText)
				self.isEditing = false
			})
			.font(.system(size: 17, weight: .semibold))
			.foregroundColor(.white)
			.textCase(.uppercase)
			.onTapGesture {
				self.isEditing = true
			}
		} else {
			Text(title)
				.font(.system(size: 17, weight: .semibold))
				.textCase(.uppercase)
				.foregroundColor(.white)
		}
	}
}
