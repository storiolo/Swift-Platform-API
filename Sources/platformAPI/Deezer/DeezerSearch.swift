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
            var playlists: [_playlist_] = []
            
            if let results = results?.data {
                for result in results {
                    playlists.append(_playlist_( result))
                }
            }
            completed(playlists)
        }
    }
    public func SearchTrack(search: String, completed: @escaping ([_track_]) -> Void){
        deezer.SearchTrack(search: search){ results in
            var tracks: [_track_] = []
            if let results = results?.data {
                for result in results {
                    tracks.append(_track_( result))
                }
            }
            completed(tracks)
        }
    }
    public func SearchUser(search: String, completed: @escaping ([_user_]) -> Void){
        deezer.SearchUser(search: search){ results in
            var users: [_user_] = []
            if let results = results?.data {
                for (index, result) in results.enumerated() {
                    users.append(_user_(result))
                    if let url = result.picture {
                        self.deezer.getImageAlbum(coverURL: url) { image in
                            users[index].image = image
                            completed(users)
                        }
                    } else {
                        completed(users)
                    }
                }
            }
        }
    }
}
