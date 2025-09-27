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
        print("API: DEVELOPPEMENT IN PROGRESS")
        completed([], nil)
    }
    
    public func loadNext(playlists: [_playlist_], url: URL?, completed: @escaping ([_playlist_], URL?) -> Void) {
        print("API: DEVELOPPEMENT IN PROGRESS")
        completed([], nil)
    }
}
