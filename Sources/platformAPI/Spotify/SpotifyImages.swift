//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI

extension _SpotifyAPI_ {
    
    public func getImageUri(_ uri: String, completed: @escaping (Image?) -> Void) {
        guard let url = URL(string: uri) else {
            completed(nil)
            return
        }
        getImageUri(url, completed: completed)
    }
    public func getImageUri(_ url: URL, completed: @escaping (Image?) -> Void) {
        let spotifyImage = SpotifyImage(url: url)
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
    
    
    
    
    public func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void) {
        guard track.image == nil else {
            completed(track.image)
            return
        }
        getImageUri(track.image_uri){ result in
            completed(result)
        }
    }
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void) {
        guard playlist.image == nil else {
            completed(playlist.image)
            return
        }
        getImageUri(playlist.image_uri){ result in
            completed(result)
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
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (_playlist_) -> Void) {
        var result: _playlist_
        result = playlist
        getImageAlbum(playlist: playlist){ image in
            result.image = image
            completed(result)
        }
    }
    
    
    
    public func getImageAlbum(playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void) {
        _imb_(items: playlists, fetch: getImageAlbum(playlist:completed:), completed: completed)
    }
    
    public func getImageAlbum(tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
        _imb_(items: tracks, fetch: getImageAlbum(track:completed:), completed: completed)
    }

}
