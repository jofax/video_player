//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation
import SwiftUI

@MainActor
class VideoPlayerViewModel: ObservableObject {
	var getVideosUserCase = GetVideosUseCase(repo: VideoRepositoryImpl(dataSource: VideoAPIImpl()))
	
	@Published var videos: [Video] = []
	@Published var video: Video?
	@Published var errorMsg = ""
	@Published var hasError = false
	
	var currentIndex = 0
	
	func fetchVideos(completion: @escaping (Bool) -> Void) async {
		errorMsg = ""
		let result = await getVideosUserCase.execute()
		switch result {
			case .success(let videos):
				self.videos = videos
				completion(true)
			case .failure(let error):
				self.videos = []
				errorMsg = error.localizedDescription
				hasError = true
				completion(false)
		}
	}
	
	func getVideo() -> Video? {
		guard videos[safe: currentIndex] != nil else {
			return nil
		}
		
		return videos[currentIndex]
	}
	
	func getTitle() -> String {
		guard let video = self.getVideo() else {
			return ""
		}
		
		return video.title
	}
	
	func getAuthor() -> String {
		guard let video = self.getVideo() else {
			return ""
		}
		
		return video.author.name
	}
	
	func getDescription() -> String {
		guard let video = self.getVideo() else {
			return ""
		}
		
		return video.description
	}
	
	func nextVideo() {
		let idx = currentIndex + 1
		guard videos[safe: idx] != nil else { return }
		currentIndex = idx
		self.video = videos[idx]
	}
	
	func previousVideo() {
		let idx = currentIndex - 1
		guard videos[safe: idx] != nil else { return }
		currentIndex = idx
		self.video = videos[idx]
	}
	
}

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
	 return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

extension String {
	func convertToDate() -> Date {
		let isoDateFormatter = ISO8601DateFormatter()
		isoDateFormatter.formatOptions = [.withFullDate]
		return isoDateFormatter.date(from: self) ?? Date()
	}
}
