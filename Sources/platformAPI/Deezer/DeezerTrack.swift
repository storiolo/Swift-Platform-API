//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getUserTracks(completed: @escaping ([_track_], URL?) -> Void){
        deezer.getUserTracks(){ results in
            let tracks = results?.data?.map(_track_.init) ?? []
            let nextURL: URL? = results?.next.flatMap { URL(string: $0) }
            completed(tracks, nextURL)
        }
    }
    
    public func getTracks(playlist_id: String, completed: @escaping ([_track_], URL?) -> Void){
        let playlist_id = playlist_id.replacingOccurrences(of: "deezer:", with: "")
        deezer.getTracks(playlist_id: playlist_id){ results in
            let tracks = results?.data?.map(_track_.init) ?? []
            let nextURL: URL? = results?.next.flatMap { URL(string: $0) }
            completed(tracks, nextURL)
        }
    }
    
    
    public func getTracks(id: [String], completed: @escaping ([_track_]) -> Void) {
        _imb_(items: id, fetch: getTrack(id:completed:), completed: completed)
    }
    
    public func getTrack(id: String, completed: @escaping (_track_) -> Void) {
        let id = id.replacingOccurrences(of: "deezer:", with: "")
        deezer.getTrack(track_id: id){ result in
            if let result = result {
                completed(_track_( result))
            }
        }
    }
}
