//
//  VideoRepositoryImpl.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation

struct VideoRepositoryImpl: VideoRepository{
	var dataSource: VideoDataSource
	
	func getVideos() async throws -> [Video] {
		let _videos = try await dataSource.getVideos()
		return _videos
	}
}
