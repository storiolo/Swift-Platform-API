//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    public func createPlaylist(title: String, completed: @escaping (String) -> Void){
        deezer.createPlaylist(title: title){ results in
            var playlist_uri = ""
            if let id = results?.id {
                playlist_uri = String(id)
            }
            completed(playlist_uri)
        }
    }
    public func addTracksToPlaylist(playlist_id: String, tracks_id: [String], completed: @escaping (Bool) -> Void){
        let playlist_id = playlist_id.replacingOccurrences(of: "deezer:", with: "")
        deezer.addTracksToPlaylist(playlist_id: playlist_id, tracks_id: tracks_id){ result in
            if let result = result {
                completed(result)
            }
        }
    }
    public func addTracksToFavorite(track_id: String, completed: @escaping (Bool) -> Void){
        let track_id = track_id.replacingOccurrences(of: "deezer:", with: "")
        deezer.addTrackToFavorite(track_id: track_id){ result in
            if let result = result {
                completed(result)
            }
        }
    }
}
