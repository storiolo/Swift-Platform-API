//
//  DeezerPlaylist.swift
//  platformAPI
//
//  Created by Nicolas Storiolo on 03/10/2025.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getAllUserPlaylists(completed: @escaping ([_playlist_], URL?) -> Void) {
        deezer.getAllUserPlaylists(){ results in
            var playlists: [_playlist_] = []
            
            if let results = results?.data {
                for result in results {
                    playlists.append(_playlist_( result))
                }
            }
            completed(playlists, nil)
        }
    }
    
    public func getAllPlaylistsOfUser(user_id: String, completed: @escaping ([_playlist_], URL?) -> Void){
        deezer.getAllPlaylistsOfUser(user_id: user_id){ results in
            var playlists: [_playlist_] = []
            
            if let results = results?.data {
                for result in results {
                    playlists.append(_playlist_( result))
                }
            }
            completed(playlists, nil)
        }
    }
}
