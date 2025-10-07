//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation

extension _SpotifyAPI_ {
    
    public func SearchPlaylist(search: String, completed: @escaping ([_playlist_]) -> Void) {
        if search.isEmpty { completed([]); return }

        self.cancellables.insert(api.search(
            query: search, categories: [.playlist], limit: 10
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { _ in  },
            receiveValue: { searchResults in
                let playlists = searchResults.playlists?.items.map { _playlist_($0) } ?? []
                completed(playlists)
            }
        )
        )
    }
    public func SearchTrack(search: String, completed: @escaping ([_track_]) -> Void) {
        if search.isEmpty { completed([]); return }
        
        self.cancellables.insert(api.search(
            query: search, categories: [.track], limit: 10
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { searchResults in
                let tracks = searchResults.tracks?.items.map { _track_($0) } ?? []
                completed(tracks)
            }
        )
        )
    }
}
