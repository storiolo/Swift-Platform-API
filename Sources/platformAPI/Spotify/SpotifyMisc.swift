//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI

extension _SpotifyAPI_ {

    public func getSongGenres(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        if tracks.tracks[index].genres.isEmpty {
            api.artist(tracks.tracks[index].artist_uri)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { artist in
                    guard let genres = artist.genres else {return}
                    tracks.tracks[index].genres = genres.joined(separator: " / ")
                    completed()
                }
            )
            .store(in: &cancellables)
        }
    }
    
    public func getImageAlbum(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        if tracks.tracks[index].image == nil {
            let spotifyImage = SpotifyImage(url: URL(string: tracks.tracks[index].image_uri)!)
            spotifyImage.load()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { image in
                        tracks.tracks[index].image = image
                        completed()
                    }
                )
            .store(in: &cancellables)
        }
    }
    public func getImageAlbum(playlists: _DataPlaylists_, index: Int, completed: @escaping () -> Void) {
        if playlists.playlists[index].image == nil {
            let spotifyImage = SpotifyImage(url: URL(string: playlists.playlists[index].image_uri)!)
            spotifyImage.load()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { image in
                        playlists.playlists[index].image = image
                        completed()
                    }
                )
            .store(in: &cancellables)
        }
    }
    
    public func getSongInfo(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        api.trackAudioFeatures(tracks.tracks[index].uri)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { audio in
                    tracks.tracks[index].features = audio
                    completed()
                }
            )
            .store(in: &cancellables)
    }
    
    public func getSongAnalysis(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        api.trackAudioAnalysis(tracks.tracks[index].uri)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { audio in
                    tracks.tracks[index].analysis = audio
                    completed()
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getSimilar(attribute: TrackAttributes, completed: @escaping (_DataTracks_) -> Void) {
        let tracks = _DataTracks_(platform: .Spotify)
        api.recommendations(attribute)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { results in
                    for result in results.tracks {
                        tracks.append(result)
                    }
                    completed(tracks)
                }
            )
            .store(in: &cancellables)
    }
    
}
