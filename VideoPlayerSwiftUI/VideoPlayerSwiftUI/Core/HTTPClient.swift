//
//  APIService.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import Foundation
import SwiftUI

/**
 Source url for adding different base API url
 **/
enum SourceURL {
	static let baseURL = "http://localhost:4000/"
}

/**
 API endpoints
 **/
enum Endpoints {
	static let videos = "videos/"
}

/**
 Request method
 **/
enum requestMethods: String {
	case POST, GET
}

/**
 MIME type of data
 **/
enum MIMEType: String {
	case JSON = "application/json"
}

/**
 Request headers
 **/
enum requestHeaders: String {
	case contentType = "Content-Type"
}

/**
 Error response
 **/
enum requestError: Error {
	case badURL, badResponse, errorDecodingData, invalidURL
}


protocol HTTPClientProtocol {
	func get<T: Decodable>(url: URL) async throws -> [T]
}

class HTTPClient: HTTPClientProtocol {
	func get<T: Decodable>(url: URL) async throws -> [T] {
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard (response as? HTTPURLResponse)?.statusCode == 200 else {
			throw requestError.badResponse
		}
		
		guard let object = try? JSONDecoder().decode([T].self, from: data) else {
			throw requestError.errorDecodingData
		}
		return object
	}
	
}
