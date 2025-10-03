//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {
    
    //Liked Songs
    public func getAllUserTracks(completed: @escaping ([_track_], URL?) -> Void) {
        api.currentUserSavedTracks(limit: 10, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let tracks = PlaylistTracks.items
                            .map(\.item)
                            .filter { !$0.isLocal }
                            .map { _track_($0) }
                    
                    completed(tracks, PlaylistTracks.next)
                }
            )
            .store(in: &self.cancellables)
    }
    
    
    public func getAllTracks(playlist_id: String, completed: @escaping ([_track_], URL?) -> Void) {
        api.playlistTracks(playlist_id, limit: 10, offset: 0)
            .extendPagesConcurrently(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistTracks in
                    let tracks = playlistTracks.items.compactMap { playlistItem -> _track_? in
                        guard let track = playlistItem.item, !track.isLocal else { return nil }
                        return _track_(track)
                    }
                    
                    completed(tracks, playlistTracks.next)
                }
            )
            .store(in: &self.cancellables)
    }

    
    
    public func getTracks(id: [String], completed: @escaping ([_track_]) -> Void) {
        api.tracks(id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { tracks in
                    let r = tracks.compactMap { $0 }.map { _track_($0) }
                    completed(r)
                }
            )
            .store(in: &cancellables)
    }
    
    public func getTrack(id: String, completed: @escaping (_track_) -> Void) {
        api.track(id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { track in
                    completed(_track_( track))
                }
            )
            .store(in: &cancellables)
    }
}
