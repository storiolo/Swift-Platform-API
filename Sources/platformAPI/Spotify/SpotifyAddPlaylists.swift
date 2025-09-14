//  playlify
//
//  Created by Nicolas Storiolo on 17/08/2023.
//

import Foundation
import SpotifyWebAPI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension _SpotifyAPI_ {
    
    
    public func createPlaylist(title: String, completed: @escaping (String) -> Void) {
        self.getUser(){ user in
            self.api.createPlaylist(for: user.uri, PlaylistDetails(name: title))
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { result in
                        completed(result.uri)
                    }
                )
                .store(in: &self.cancellables)
        }
    }
    
    
    public func addTracksToPlaylist(playlist_id: String, tracks_id: [String], completed: @escaping (Bool) -> Void) {
        let chunckedTracks = tracks_id.chunked(into: 100)
        addChunkTracks(index: 0, completion: completed)
        
        func addChunkTracks(index: Int, completion: @escaping (Bool) -> Void) {
            guard index < chunckedTracks.count else {
                completion(true)
                return
            }

            self.api.addToPlaylist(playlist_id, uris: chunckedTracks[index])
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { _ in
                        addChunkTracks(index: index + 1, completion: completion)
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    public func addTracksToFavorite(track_id: String, completed: @escaping (Bool) -> Void) {
        self.api.saveTracksForCurrentUser([track_id])
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in completed(true) }
            )
            .store(in: &cancellables)
    }
    
    
}
