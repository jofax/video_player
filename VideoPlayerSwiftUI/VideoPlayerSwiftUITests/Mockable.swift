//
//  Mockable.swift
//  VideoPlayerSwiftUITests
//
//  Created by joseph on 2023-10-23.
//

import Foundation


protocol Mockable: AnyObject {
	var bundle: Bundle { get }
	func loadJSONFile<T: Decodable>(filename: String, type: T.Type) ->  [T]
}

extension Mockable {
	var bundle: Bundle {
		return Bundle(for: type(of: self))
	}
	
	func loadJSONFile<T: Decodable>(filename: String, type: T.Type) -> [T] {
		guard let path = bundle.url(forResource: filename, withExtension: "json") else {
			fatalError("Unable to load JSON file.")
		}
		
		do {
			let data = try Data(contentsOf: path)
			let decodedData = try JSONDecoder().decode([T].self, from: data)
			return decodedData
		} catch {
			fatalError("Failed to load JSON.")
		}
	}
}
