//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {
    public func Play() {
        self.api.resumePlayback()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    public func Pause() {
        self.api.pausePlayback()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    public func Next() {
        self.api.skipToNext()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    public func Previous() {
        self.api.skipToPrevious()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    public func UserQueue(completed: @escaping ([_track_]) -> Void) {
        self.api.queue()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { SpotifyQueue in
                    
                    let uris = SpotifyQueue.queue.compactMap { $0.uri }
                    self.getTracks(id: uris){ tracks in
                        completed(tracks)
                    }
                    
                }
            )
            .store(in: &cancellables)
    }
    
    public func AddToUserQueue(track_id: String) {
        self.api.addToQueue(track_id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    
    public func Play(tracks_id: [String]) {
        let playbackRequest = PlaybackRequest(
            context: .uris(tracks_id),
            offset: nil
        )
        
        self.api.play(playbackRequest)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    public func Play(track_id: String) {
        Play(tracks_id: [track_id])
    }
}
