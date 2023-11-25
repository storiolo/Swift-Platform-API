//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    public func SearchPlaylist(search: String, completed: @escaping (_DataPlaylists_) -> Void){
        self.SearchPlaylist(search: search, max: 10, completed: completed)
    }
    public func SearchPlaylist(search: String, max: Int, completed: @escaping (_DataPlaylists_) -> Void){
        deezer.SearchPlaylist(search: search, max: max){ results in
            var playlists: _DataPlaylists_
            playlists = _DataPlaylists_(platform: .Deezer)
            if let results = results?.data {
                for result in results {
                    playlists.append(result)
                }
            }
            completed(playlists)
        }
    }
    public func SearchTrack(search: String, completed: @escaping (_DataTracks_) -> Void){
        deezer.SearchTrack(search: search){ results in
            var tracks: _DataTracks_
            tracks = _DataTracks_(platform: .Deezer)
            if let results = results?.data {
                for result in results {
                    tracks.append(result)
                }
            }
            completed(tracks)
        }
    }
    public func SearchUser(search: String, completed: @escaping (_DataUsers_) -> Void){
        deezer.SearchUser(search: search){ results in
            var users: _DataUsers_
            users = _DataUsers_(platform: .Deezer)
            if let results = results?.data {
                for (index, result) in results.enumerated() {
                    users.append(result)
                    if let url = result.picture {
                        self.deezer.getImageAlbum(coverURL: url) { image in
                            users.users[index].image = image
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
