//
//  ImageLoader.swift
//  Weather-SwiftUI
//
//  Created by Akylbek Utekeshev on 5/24/21.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
	@Published var image: UIImage?
	
	private var cancellable: AnyCancellable?
	
	func load(url: URL) {
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map { UIImage(data: $0.data) }
			.replaceError(with: nil)
			.receive(on: DispatchQueue.main)
			.assign(to: \.image, on: self)
	}
	
	func cancel() {
		cancellable?.cancel()
	}
}

struct AsyncImage: View {
	@StateObject private var loader: ImageLoader
	@Binding private var url: URL?
	
	init(url: Binding<URL?>) {
		_url = url
		_loader = StateObject(wrappedValue: ImageLoader())
	}
	
	var body: some View {
		image
			.onDisappear(perform: loader.cancel)
			.onChange(of: url, perform: { value in
				guard let url = value else { return }
				loader.load(url: url)
			})
	}
	
	private var image: some View {
		Group {
			if loader.image != nil {
				Image(uiImage: loader.image!)
					.resizable()
			} else {
				Text("")
			}
		}
	}
}
