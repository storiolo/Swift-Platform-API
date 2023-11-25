//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation

extension _SpotifyAPI_ {
    
    public func SearchPlaylist(search: String, completed: @escaping (_DataPlaylists_) -> Void) {
        self.SearchPlaylist(search: search, max: 10, completed: completed)
    }
    
    public func SearchPlaylist(search: String, max: Int, completed: @escaping (_DataPlaylists_) -> Void) {
        var playlists: _DataPlaylists_
        playlists = _DataPlaylists_(platform: .Spotify)
        if search.isEmpty { completed(playlists); return }

        self.cancellables.insert(api.search(
            query: search, categories: [.playlist], limit: max
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { _ in  },
            receiveValue: { searchResults in
                guard let results = searchResults.playlists?.items else { return }
                for result in results {
                    playlists.append(result)
                }
                completed(playlists)
            }
        )
        )
    }
    public func SearchTrack(search: String, completed: @escaping (_DataTracks_) -> Void) {
        var tracks: _DataTracks_
        tracks = _DataTracks_(platform: .Spotify)
        if search.isEmpty { completed(tracks); return }

        self.cancellables.insert(api.search(
            query: search, categories: [.track], limit: 5
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { searchResults in
                guard let results = searchResults.tracks?.items else { return }
                for result in results {
                    tracks.append(result)
                }
                completed(tracks)
            }
        )
        )
    }
    public func SearchUser(search: String, completed: @escaping (_DataUsers_) -> Void) {
        print("Not Available on Spotify")
        completed(_DataUsers_(platform: .Spotify))
    }
}
