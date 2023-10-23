//
//  MockHttpClient.swift
//  VideoPlayerSwiftUITests
//
//  Created by joseph on 2023-10-23.
//

import Foundation
@testable import VideoPlayerSwiftUI

final class MockHttpClient: HTTPClientProtocol, Mockable {
	func get<T: Decodable>(url: URL) async throws -> [T] where T : Decodable {
		if (url.absoluteString.hasPrefix("videos")) {
			return loadJSONFile(filename: "videos", type: T.self)
		} else {
			return loadJSONFile(filename: "videos", type: T.self)
		}
	}
	
}
