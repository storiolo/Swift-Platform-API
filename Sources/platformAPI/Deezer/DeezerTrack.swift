//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getAllTracks(playlist_id: String, completed: @escaping (_DataTracks_) -> Void){
        deezer.getAllTracks(playlist_id: playlist_id){ results in
            var tracks: _DataTracks_
            tracks = _DataTracks_(platform: .Deezer, uri: playlist_id)
            if let results = results?.data {
                for result in results {
                    tracks.append(result)
                }
            }
            completed(tracks)
        }
    }
    
    public func getTrack(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        deezer.getTrack(track_id: tracks.tracks[index].uri){ result in
            if let result = result {
                tracks.tracks[index] = _DataTracks_._track_(track: result)
            }
            completed()
        }
    }
}
