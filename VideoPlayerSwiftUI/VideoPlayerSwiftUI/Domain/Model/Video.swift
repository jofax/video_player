//
//  Video.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation

struct Video: Identifiable {
	var id: String
	var title: String
	var hlsURL: String
	var fullURL: String
	var description: String
	var publishedAt: String
	var author: Author
}
