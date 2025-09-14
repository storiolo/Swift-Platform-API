//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void) {
        if track.image == nil && !track.image_uri.isEmpty {
            deezer.getImageAlbum(coverURL: track.image_uri){ image in
                completed(image ?? nil)
            }
        }
    }
    
    public func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void) {
        if playlist.image == nil && !playlist.image_uri.isEmpty {
            deezer.getImageAlbum(coverURL: playlist.image_uri){ image in
                completed(image ?? nil)
            }
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

    
//    public func getSongGenres(tracks: inout [_track_], index: Int, completed: @escaping () -> Void) {
//        deezer.getTrack(track_id: tracks[index].uri){ track in
//            if let album_id = track?.album?.id {
//                self.deezer.getAlbum(album_id: String(album_id)){ album in
//                    if let genres = album?.genres?.data {
//                        var arr_genres: [String] = []
//                        for genre in genres {
//                            arr_genres.append(genre.name ?? "")
//                        }
//                        tracks[index].genres = arr_genres.joined(separator: " / ")
//                        completed()
//                    } else {
//                        completed()
//                    }
//                }
//            } else {
//                completed()
//            }
//        }
//    }
    
    
    public func getSongInfo(tracks: [_track_], index: Int, completed: @escaping () -> Void) {
        print("Not Available on Deezer")
        completed()
    }
    
    public func getSongAnalysis(tracks: [_track_], index: Int, completed: @escaping () -> Void) {
        print("Not Available on Deezer")
        completed()
    }
    
}
