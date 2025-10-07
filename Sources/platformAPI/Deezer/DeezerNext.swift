//
//  DeezerNext.swift
//  platformAPI
//
//  Created by Nicolas Storiolo on 03/10/2025.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    public func loadNext(tracks: [_track_], url: URL?, completed: @escaping ([_track_], URL?) -> Void) {
        guard let url = url else {
            completed(tracks, nil)
            return
        }

        deezer.getNext(DeezerDataTrack.self, urlNext: url.absoluteString) { result in
            let newTracks = result?.data?.map { _track_($0) } ?? []
            let nextURL = result?.next.flatMap { URL(string: $0) }
            completed(tracks + newTracks, nextURL)
        }
    }
    
    public func loadNext(playlists: [_playlist_], url: URL?, completed: @escaping ([_playlist_], URL?) -> Void) {
        guard let url = url else {
            completed(playlists, nil)
            return
        }

        deezer.getNext(DeezerDataPlaylist.self, urlNext: url.absoluteString) { result in
            let newTracks = result?.data?.map { _playlist_($0) } ?? []
            let nextURL = result?.next.flatMap { URL(string: $0) }
            completed(playlists + newTracks, nextURL)
        }
    }
}
