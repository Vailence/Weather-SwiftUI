//
//  MainView.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/24/21.
//

import SwiftUI

struct MainView: View {
	
	@ObservedObject var viewModel: MainViewModel
	
	@State private var showBottomView = false
	@State private var isEditing = false
	@State private var searchText: String = ""
	@State private var fadeInOut: Bool = false
	
	var body: some View {
		ZStack {
			BackgroundGradient(type: $viewModel.type)
			
			VStack(alignment: .leading, spacing: 16) {
				CityView(title: .constant(viewModel.cityName),
						 isEditing: $isEditing,
						 searchText: $searchText) { text -> Void? in
					self.viewModel.setNewCity(text)
				}
				.onTapGesture {
					isEditing.toggle()
				}
				
				TemperatureView(degrees: .constant(viewModel.degrees))
				
				VStack(alignment: .leading, spacing: 8) {
					Text(viewModel.mainTitle)
						.fontWeight(.bold)
						.font(.largeTitle)
						.textCase(.uppercase)
						.foregroundColor(.white)
					Text(viewModel.descriptionTitle)
						.fontWeight(.semibold)
						.font(.headline)
						.textCase(.uppercase)
						.foregroundColor(.white)
				}
				
				if let url = viewModel.iconURL {
					AsyncImage(url: url, placeholder: Text(""))
						.frame(width: 100, height: 100)
						.aspectRatio(contentMode: .fit)
				}
				Spacer()
				
				BottomView(humidity: .constant(viewModel.humidity),
						   visibility: .constant(viewModel.visibility),
						   pressure: .constant(viewModel.pressure))
					.onTapGesture {
						showBottomView.toggle()
					}
			}
			.padding([.horizontal, .top], 16)
			.padding(.bottom, 32)
		}
		.onAppear() {
			withAnimation(.easeInOut(duration: 1)) {
				fadeInOut.toggle()
			}
		}
		.blur(radius: fadeInOut ? 0 : 10)
		.onTapGesture {
			self.isEditing = false
		}
		.alert(isPresented: $viewModel.showAlert) {
			Alert(title: Text(viewModel.alertMessage),
				  dismissButton: .default(Text("Got it!")))
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView(viewModel: MainViewModel())
			.preferredColorScheme(.dark)
	}
}
