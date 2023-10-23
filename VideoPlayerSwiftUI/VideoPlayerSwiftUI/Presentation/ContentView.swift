//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		NavigationView {
			VideoPlayerView()
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarTitle("Video Player")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
