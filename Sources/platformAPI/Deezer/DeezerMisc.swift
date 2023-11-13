//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getImageAlbum(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void){
        if tracks.tracks[index].image == nil && !tracks.tracks[index].image_uri.isEmpty {
            deezer.getImageAlbum(coverURL: tracks.tracks[index].image_uri){ image in
                tracks.tracks[index].image = image
                completed()
            }
        }
    }
    public func getImageAlbum(playlists: _DataPlaylists_, index: Int, completed: @escaping () -> Void){
        if playlists.playlists[index].image == nil && !playlists.playlists[index].image_uri.isEmpty {
            deezer.getImageAlbum(coverURL: playlists.playlists[index].image_uri){ image in
                playlists.playlists[index].image = image
                completed()
            }
        }
    }
    
    public func getSongGenres(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
//        deezer.getTrack(track_id: tracks.tracks[index].uri){ track in
//            if let genre_id = track?.album?.genre_id {
//                self.deezer.getGenres(genre_id: String(genre_id)){ genres in
//                    if let genres = genres?.data {
//                        var arr_genres: [String] = []
//                        for genre in genres {
//                            arr_genres.append(genre.name ?? "")
//                        }
//                        tracks.tracks[index].genres = arr_genres.joined(separator: " / ")
//                        completed()
//                    } else {
//                        completed()
//                    }
//                }
//            } else {
//                completed()
//            }
//        }
        print("Not working on Deezer")
        completed()
    }
    
    public func getSongInfo(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("Not Available on Deezer")
        completed()
    }
    
    public func getSongAnalysis(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("Not Available on Deezer")
        completed()
    }
    
    public func getPlaylist(playlist_id: String, completed: @escaping (_DataPlaylists_) -> Void) {
         deezer.getPlaylist(playlist_id: playlist_id){ results in
             print(results?.total)
             print("??")
             var playlists: _DataPlaylists_
             playlists = _DataPlaylists_(platform: .Deezer)
             if let results = results?.data {
                 for result in results {
                     playlists.append(result)
                 }
             }
             completed(playlists)
         }

     }
}
