//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getAllTracks(playlist_id: String, completed: @escaping ([_track_]) -> Void){
        deezer.getAllTracks(playlist_id: playlist_id){ results in
            var tracks: [_track_] = []
            if let results = results?.data {
                for result in results {
                    tracks.append(_track_( result))
                }
            }
            completed(tracks)
        }
    }
    
    
    public func getTracks(id: [String], completed: @escaping ([_track_]) -> Void) {
        var tracks: [_track_] = []

        openNextTrack(currentIndex: 0)
        func openNextTrack(currentIndex: Int){
            guard currentIndex < id.count else {
                completed(tracks)
                return
            }
            
            getTrack(id: id[currentIndex]){ result in
                tracks.append(result)
                openNextTrack(currentIndex: currentIndex+1)
            }
        }
    }
    
    public func getTrack(id: String, completed: @escaping (_track_) -> Void) {
        deezer.getTrack(track_id: id){ result in
            if let result = result {
                completed(_track_( result))
            }
        }
    }
}
