//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    public func SearchPlaylist(search: String, completed: @escaping ([_playlist_]) -> Void){
        deezer.SearchPlaylist(search: search, max: 10){ results in
            let playlists = results?.data?.map(_playlist_.init) ?? []
            completed(playlists)
        }
    }
    public func SearchTrack(search: String, completed: @escaping ([_track_]) -> Void){
        deezer.SearchTrack(search: search){ results in
            let tracks = results?.data?.map(_track_.init) ?? []
            completed(tracks)
        }
    }
}
