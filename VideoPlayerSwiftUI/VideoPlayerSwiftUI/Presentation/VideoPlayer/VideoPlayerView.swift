//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by joseph on 2023-10-20.
//

import SwiftUI
import AVKit


struct VideoPlayerView: View {
	@ObservedObject private var viewModel = VideoPlayerViewModel()
	@State private var player : AVPlayer?
	@State var isPlaying : Bool = false
	
	var body: some View {
		VStack {
			ZStack {
				VideoPlayer(player: player)
					.frame(width: UIScreen.main.bounds.width,
						   height: 300,
						   alignment: .center)
				
				HStack(spacing: 40) {
					Button(action: previousVideo) {
						Image("previous")
								.foregroundColor(.black)
								.padding()
								.background(Color.white)
								.clipShape(Circle())
					}
					
					Button(action: isPlaying ? pauseVideo : playVideo) {
						Image(isPlaying ? "pause" : "play")
								.foregroundColor(.black)
								.padding()
								.background(Color.white)
								.clipShape(Circle())
					}
					
					Button(action: nextVideo) {
						Image("next")
								.foregroundColor(.black)
								.padding()
								.background(Color.white)
								.clipShape(Circle())
					}
					
				}
			}
			
			ScrollView {
				VStack(alignment: .leading) {
					Text(viewModel.getTitle())
						.lineLimit(1)
						.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
					
					Text(viewModel.getAuthor())
						.lineLimit(1)
						.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
					
					 
					Text("""
						 \(viewModel.getDescription())
						 """)
						.lineLimit(nil)
						.padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
						
				}
				.frame(width: UIScreen.main.bounds.width)
			}
		}
		.onAppear(perform: {
			
			Task {
				await viewModel.fetchVideos { _ in
					loadVideo()
				}
			}
		})
	}
	
	func loadVideo() {
		_ = viewModel.getTitle()
		_ = viewModel.getDescription()
		_ = viewModel.getAuthor()
		
		guard let video = viewModel.getVideo() else {
			return
		}
		
		guard let url = URL(string: video.fullURL) else { return }
			player = AVPlayer(url: url)

	}
	
	func nextVideo() {
		isPlaying = false
		player?.pause()
		player = nil
		viewModel.nextVideo()
	}
	
	func playVideo() {
		isPlaying =  true
		if player != nil {
			player?.play()
		} else {
		   loadVideo()
		   player?.play()
		   
		}
	}
	
	func pauseVideo() {
		isPlaying = false
		player?.pause()
	}
	
	func previousVideo() {
		isPlaying = false
		player?.pause()
		player = nil
		viewModel.previousVideo()
	}
}

struct VideoPlayerView_Previews: PreviewProvider {
	static var previews: some View {
		VideoPlayerView()
	}
}
