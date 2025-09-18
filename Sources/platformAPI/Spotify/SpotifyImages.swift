//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI

extension _SpotifyAPI_ {
    
    public func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void) {
        if track.image == nil && !track.uri.isEmpty {
            let spotifyImage = SpotifyImage(url: URL(string: track.image_uri)!)
            spotifyImage.load()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { image in
                        completed(image)
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void) {
        if playlist.image == nil  && !playlist.uri.isEmpty {
            let spotifyImage = SpotifyImage(url: URL(string: playlist.image_uri)!)
            spotifyImage.load()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { image in
                        completed(image)
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    
    
    
    public func getImageAlbum(track: _track_, completed: @escaping (_track_) -> Void) {
        var result: _track_
        result = track
        getImageAlbum(track: track){ image in
            result.image = image
            completed(result)
        }
    }
    
//    public func getImageAlbum(tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
//        var out: [_track_] = []
//
//        openNextTrack(currentIndex: 0)
//        func openNextTrack(currentIndex: Int){
//            guard currentIndex < tracks.count else {
//                completed(out)
//                return
//            }
//            
//            getImageAlbum(track: tracks[currentIndex]){ result in
//                out.append(result)
//                openNextTrack(currentIndex: currentIndex+1)
//            }
//        }
//    }
    
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (_playlist_) -> Void) {
        var result: _playlist_
        result = playlist
        getImageAlbum(playlist: playlist){ image in
            result.image = image
            completed(result)
        }
    }
    
//    public func getImageAlbum(playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void) {
//        var out: [_playlist_] = []
//
//        openNextTrack(currentIndex: 0)
//        func openNextTrack(currentIndex: Int){
//            guard currentIndex < playlists.count else {
//                completed(out)
//                return
//            }
//            
//            getImageAlbum(playlist: out[currentIndex]){ result in
//                out.append(result)
//                openNextTrack(currentIndex: currentIndex+1)
//            }
//        }
//    }
    
    public func getImageAlbum(playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void) {
        _imb_(items: playlists, fetch: getImageAlbum(playlist:completed:), completed: completed)
    }
    
    public func getImageAlbum(tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
        _imb_(items: tracks, fetch: getImageAlbum(track:completed:), completed: completed)
    }


    
}
