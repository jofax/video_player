//
//  VIdeoAPIEntity.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation

struct VideoAPIEntity: Decodable {
	
	var id: String
	var title: String
	var hlsURL: String
	var fullURL: String
	var description: String
	var publishedAt: String
	var author: Author
	
}
