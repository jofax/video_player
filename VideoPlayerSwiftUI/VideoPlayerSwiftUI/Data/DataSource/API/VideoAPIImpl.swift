//
//  VideoAPIImpl.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation

struct VideoAPIImpl: VideoDataSource {
	let client: HTTPClientProtocol = HTTPClient()
	func getVideos() async throws -> [Video] {
		guard let video_url = URL(string: SourceURL.baseURL + Endpoints.videos) else {
			throw requestError.badURL
		}
		
		guard let videos: [VideoAPIEntity]  = try? await client.get(url: video_url) else{
			throw requestError.badResponse
		}
		
		return videos.map { item in
			Video(id: item.id,
				  title: item.title,
				  hlsURL: item.hlsURL,
				  fullURL: item.fullURL,
				  description: item.description,
				  publishedAt: item.publishedAt,
				  author: Author(id: item.author.id, name: item.author.name))
		}
	}
}
