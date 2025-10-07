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
    
    public func getUserPlaylists(completed: @escaping ([_playlist_], URL?) -> Void) {
        deezer.getUserPlaylists { results in
            let playlists = results?.data?.map { _playlist_($0) } ?? []
            let nextURL: URL? = results?.next.flatMap { URL(string: $0) }
            completed(playlists, nextURL)
        }
    }
    
    public func getPlaylistsOfUser(user_id: String, completed: @escaping ([_playlist_], URL?) -> Void){
        deezer.getPlaylistsOfUser(user_id: user_id){ results in
            let playlists = results?.data?.map { _playlist_($0) } ?? []
            let nextURL: URL? = results?.next.flatMap { URL(string: $0) }
            completed(playlists, nextURL)
        }
    }
}
