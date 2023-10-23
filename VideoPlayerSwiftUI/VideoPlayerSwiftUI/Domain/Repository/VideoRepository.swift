//
//  VideoRepository.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation

protocol VideoRepository {
	func getVideos() async throws -> [Video]
}
