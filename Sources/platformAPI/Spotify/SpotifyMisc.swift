//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI

extension _SpotifyAPI_ {

    public func getSongGenres(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        if index < tracks.tracks.count {
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
    }
    public func getSongsGenres(tracks: _DataTracks_, completed: @escaping () -> Void) {
        if tracks.tracks.count > 0 {

            //retrieve only tracks with empty genres
            var tmpIndex: [Int] = [] //index of songs with no genres in tracks
            var tmpArtists_arr: [[String]] = [[]] //pack of 50 of artist_uri
            tmpArtists_arr.append([])
            var tmpArtistsIndex = 0 //index of Artists
            
            for (index, track) in tracks.tracks.enumerated() {
                if track.genres.isEmpty {
                    if tmpArtists_arr[tmpArtistsIndex].count >= 50 {
                        tmpArtistsIndex += 1
                        tmpArtists_arr.append([])
                    }
                    tmpArtists_arr[tmpArtistsIndex].append(track.artist_uri)
                    tmpIndex.append(index)
                }
            }
            
            if !tmpIndex.isEmpty {
                //Load artists
                for (index, tmpArtists) in tmpArtists_arr.enumerated() {
                    api.artists(tmpArtists)
                        .receive(on: DispatchQueue.main)
                        .sink(
                            receiveCompletion: { _ in },
                            receiveValue: { artists in
                                for artist in artists {
                                    if let genres = artist?.genres {
                                        tracks.tracks[tmpIndex[index]].genres = genres.joined(separator: " / ")
                                    }
                                }
                            }
                        )
                        .store(in: &cancellables)
                }
            }
            
        }
    }
    
    public func getImageAlbum(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        if index < tracks.tracks.count {
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
    }
    public func getImageAlbum(playlists: _DataPlaylists_, index: Int, completed: @escaping () -> Void) {
        if index < playlists.playlists.count {
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
    }
    
    public func getSongInfo(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        if index < tracks.tracks.count {
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
    }
    
    public func getSongAnalysis(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        if index < tracks.tracks.count {
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
    
    public func getPlaylist(playlist_id: String, completed: @escaping (_DataPlaylists_) -> Void) {
         var playlists: _DataPlaylists_
         playlists = _DataPlaylists_(platform: .Spotify)

         self.api.playlist(playlist_id)
             .receive(on: DispatchQueue.main)
             .sink(
                 receiveCompletion: { _ in },
                 receiveValue: { playlistsItem in

                     playlists.playlists.append(_DataPlaylists_._playlist_(
                         title: playlistsItem.name,
                         uri: playlistsItem.uri,
                         image_uri: playlistsItem.images.largest?.url.absoluteString ?? "",
                         creator_uri: playlistsItem.owner?.uri ?? ""))

                     completed(playlists)
                 }
             )
             .store(in: &cancellables)
     }
}
