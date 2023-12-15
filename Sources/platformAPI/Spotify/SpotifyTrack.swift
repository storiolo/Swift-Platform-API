//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {
    
    public func getAllTracks(playlist_id: String, completed: @escaping (_DataTracks_) -> Void) {
        var concatenatedTracks: _DataTracks_
        concatenatedTracks = _DataTracks_(platform: .Spotify, uri: playlist_id)
        api.playlistTracks(playlist_id, offset: 0)
            .extendPagesConcurrently(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems_ = PlaylistTracks.items.map(\.item)
                    let playlistItems: [Track] = playlistItems_.compactMap { $0 }
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        concatenatedTracks.append(playlistItem)
                    }
                    
                    let status_id = self.arrStatus.add_status(text: "Loading Songs Genre", ld_max: 0)
                    print(self.arrStatus.status.count)
                    self.loadNextPage_Tracks(status_id: status_id, currentPage: PlaylistTracks.next, previousPage: nil, tracks: concatenatedTracks){ tracks_ in
//                        self.arrStatus.delete_status(id: status_id)
                        completed(tracks_)
                    }
                }
            )
            .store(in: &self.cancellables)
    }
    

    public func getTrack(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        self.getTrack(uri: tracks.tracks[index].uri){ track in
            tracks.tracks[index] = track
            completed()
        }
    }
    public func getTrack(uri: String, completed: @escaping (_DataTracks_._track_) -> Void) {
        api.track(uri)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { track in
                    completed(_DataTracks_._track_(track: track))
                }
            )
            .store(in: &cancellables)
    }
}
