//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI

extension _SpotifyAPI_ {


    
    
//    public func getSongGenres(tracks: [_track_], index: Int, completed: @escaping () -> Void) {
//        if index < tracks.count {
//            if tracks[index].genres.isEmpty {
//                api.artist(tracks[index].artist_uri)
//                    .receive(on: DispatchQueue.main)
//                    .sink(
//                        receiveCompletion: { _ in },
//                        receiveValue: { artist in
//                            guard let genres = artist.genres else {return}
//                            tracks[index].genres = genres.joined(separator: " / ")
//                            completed()
//                        }
//                    )
//                    .store(in: &cancellables)
//            } else {
//                completed()
//            }
//        } else {
//            completed()
//        }
//    }
//    public func getSongsGenres(index: Int, tracks: [_track_], completed: @escaping () -> Void) {
//        if tracks.count > 0 {
//            
//            //retrieve only tracks with empty genres
//            var tmpIndex: [Int] = [] //index of songs with no genres in tracks
//            var tmpArtists_arr: [[String]] = [[]] //pack of 50 of artist_uri
//            tmpArtists_arr.append([])
//            var tmpArtistsIndex = 0 //index of Artists
//            
//            for (index, track) in tracks.enumerated() {
//                if track.genres.isEmpty {
//                    if tmpArtists_arr[tmpArtistsIndex].count >= 50 {
//                        tmpArtistsIndex += 1
//                        tmpArtists_arr.append([])
//                    }
//                    tmpArtists_arr[tmpArtistsIndex].append(track.artist_uri)
//                    tmpIndex.append(index)
//                }
//            }
//            
//            if !tmpIndex.isEmpty {
//                //Load artists
//                var index_ = 0
//                let status_id = self.arrStatus.add_status(text: "Loading Songs Genre", ld_max: tmpArtists_arr.count)
//                loadNext(currentIndex: index)
//                func loadNext(currentIndex: Int){
//                    guard currentIndex < tmpArtists_arr.count else {
//                        self.arrStatus.delete_status(id: status_id)
//                        completed()
//                        return
//                    }
//                    
//                    
//                    self.arrStatus.inc_status(id: status_id)
//                    api.artists(tmpArtists_arr[currentIndex])
//                        .receive(on: DispatchQueue.main)
//                        .sink(
//                            receiveCompletion: { _ in },
//                            receiveValue: { artists in
//                                for artist in artists {
//                                    if let genres = artist?.genres {
//                                        tracks[tmpIndex[index_]].genres = genres.joined(separator: " / ")
//                                        index_ += 1
//                                    }
//                                }
//                                loadNext(currentIndex: currentIndex+1)
//                            }
//                        )
//                        .store(in: &cancellables)
//                }
//            } else {
//                completed()
//            }
//            
//        }
//    }
    
    
    public func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void) {
        if track.image == nil && !track.uri.isEmpty {
            let spotifyImage = SpotifyImage(url: URL(string: track.image_uri)!)
            spotifyImage.load()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { image in
                        completed(image)
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void) {
        if playlist.image == nil  && !playlist.uri.isEmpty {
            let spotifyImage = SpotifyImage(url: URL(string: playlist.image_uri)!)
            spotifyImage.load()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { image in
                        completed(image)
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    
    
    
    public func getImageAlbum(track: _track_, completed: @escaping (_track_) -> Void) {
        var result: _track_
        result = track
        getImageAlbum(track: track){ image in
            result.image = image
            completed(result)
        }
    }
    
    public func getImageAlbum(tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
        var out: [_track_] = []

        openNextTrack(currentIndex: 0)
        func openNextTrack(currentIndex: Int){
            guard currentIndex < tracks.count else {
                completed(out)
                return
            }
            
            getImageAlbum(track: tracks[currentIndex]){ result in
                out.append(result)
                openNextTrack(currentIndex: currentIndex+1)
            }
        }
    }
    
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (_playlist_) -> Void) {
        var result: _playlist_
        result = playlist
        getImageAlbum(playlist: playlist){ image in
            result.image = image
            completed(result)
        }
    }
    
    public func getImageAlbum(playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void) {
        var out: [_playlist_] = []

        openNextTrack(currentIndex: 0)
        func openNextTrack(currentIndex: Int){
            guard currentIndex < playlists.count else {
                completed(out)
                return
            }
            
            getImageAlbum(playlist: out[currentIndex]){ result in
                out.append(result)
                openNextTrack(currentIndex: currentIndex+1)
            }
        }
    }
    
    
    
//    public func getSongInfo(tracks: [_track_], index: Int, completed: @escaping () -> Void) {
//        if index < tracks.count {
//            api.trackAudioFeatures(tracks[index].uri)
//                .receive(on: DispatchQueue.main)
//                .sink(
//                    receiveCompletion: { _ in },
//                    receiveValue: { audio in
//                        tracks[index].features = audio
//                        completed()
//                    }
//                )
//                .store(in: &cancellables)
//        }
//    }
//    
//    public func getSongAnalysis(tracks: [_track_], index: Int, completed: @escaping () -> Void) {
//        if index < tracks.count {
//            api.trackAudioAnalysis(tracks[index].uri)
//                .receive(on: DispatchQueue.main)
//                .sink(
//                    receiveCompletion: { _ in },
//                    receiveValue: { audio in
//                        tracks[index].analysis = audio
//                        completed()
//                    }
//                )
//                .store(in: &cancellables)
//        }
//    }
//    
//    
//    public func getSimilar(attribute: TrackAttributes, completed: @escaping ([_track_]) -> Void) {
//        let tracks = [_track_](platform: .Spotify)
//        api.recommendations(attribute)
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { _ in },
//                receiveValue: { results in
//                    for result in results.tracks {
//                        tracks.append(result)
//                    }
//                    completed(tracks)
//                }
//            )
//            .store(in: &cancellables)
//    }
    
}
