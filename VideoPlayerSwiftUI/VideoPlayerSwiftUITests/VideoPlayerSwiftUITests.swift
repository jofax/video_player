//
//  VideoPlayerSwiftUITests.swift
//  VideoPlayerSwiftUITests
//
//  Created by joseph on 2023-10-20.
//

import XCTest
@testable import VideoPlayerSwiftUI

final class VideoPlayerSwiftUITests: XCTestCase {
	
	var testvm: VideoPlayerViewModel!
	
	@MainActor
	override func setUp() {
		super.setUp()
		testvm = VideoPlayerViewModel()
	}
	
	override func tearDown() {
		super.tearDown()
		testvm = nil
	}
	
	@MainActor
	func testGetVideoStub() async throws {
		await testvm.fetchVideos(completion: { _ in })
		XCTAssertEqual(self.testvm.videos.count, 2)
	}

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
