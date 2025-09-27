//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void) {
        if track.image == nil && !track.image_uri.isEmpty {
            deezer.getImageAlbum(coverURL: track.image_uri){ image in
                completed(image ?? nil)
            }
        }
    }
    
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void) {
        if playlist.image == nil && !playlist.image_uri.isEmpty {
            deezer.getImageAlbum(coverURL: playlist.image_uri){ image in
                completed(image ?? nil)
            }
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
