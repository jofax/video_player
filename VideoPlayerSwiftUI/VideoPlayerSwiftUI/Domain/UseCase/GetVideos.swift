//
//  GetVideos.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation

enum UseCaseError: Error {
	case networkError, decodingError
}

protocol GetVideos {
	func execute() async -> Result<[Video], UseCaseError>
}

struct GetVideosUseCase: GetVideos {
	var repo: VideoRepository
	func execute() async -> Result<[Video], UseCaseError> {
		do {
			let videos = try await repo.getVideos()
			return .success(videos)
		} catch (let error) {
			switch (error) {
				case requestError.errorDecodingData:
					return .failure(.decodingError)
				default:
					return .failure(.networkError)
			}
		}
	}
	
}
