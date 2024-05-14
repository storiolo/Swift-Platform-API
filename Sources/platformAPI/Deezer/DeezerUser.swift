//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getUser(completed: @escaping (_DataUsers_) -> Void) {
        deezer.getUser(){ user in
            var datauser: _DataUsers_
            datauser = _DataUsers_(platform: .Deezer)
            
            if let user = user {
                datauser.append(user)
                if let url = user.picture {
                    self.deezer.getImageAlbum(coverURL: url) { image in
                        datauser.users[0].image = image
                        completed(datauser)
                    }
                } else {
                    completed(datauser)
                }
            } else {
                completed(datauser)
            }
        }
    }
    
    public func getUser(user_id: String, completed: @escaping (_DataUsers_) -> Void) {
        deezer.getaUser(user_id: user_id){ user in
            var datauser: _DataUsers_
            datauser = _DataUsers_(platform: .Deezer)
            
            if let user = user {
                datauser.append(user)
                if let url = user.picture {
                    self.deezer.getImageAlbum(coverURL: url) { image in
                        datauser.users[0].image = image
                        completed(datauser)
                    }
                } else {
                    completed(datauser)
                }
            } else {
                completed(datauser)
            }
        }
    }
    
    public func getAllUserPlaylists(completed: @escaping (_DataPlaylists_) -> Void){
        deezer.getAllUserPlaylists(){ results in
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
    
    public func getUserCurrentSong(lastTrack: _DataTracks_, completed: @escaping (_DataTracks_) -> Void) {
        print("Not Available on Deezer")
        completed(_DataTracks_(platform: .Deezer))
    }
    
    public func getAllUserTracks(completed: @escaping (_DataTracks_) -> Void){
        deezer.getAllUserTracks(){ results in
            var tracks: _DataTracks_
            tracks = _DataTracks_(platform: .Deezer)
            if let results = results?.data {
                for result in results {
                    tracks.append(result)
                }
            }
            completed(tracks)
        }
    }
    
    public func getAllUserTracks(index: Int, completed: @escaping (_DataTracks_) -> Void){
        deezer.getAllUserTracks(index: index){ results in
            var tracks: _DataTracks_
            tracks = _DataTracks_(platform: .Deezer)
            if let results = results?.data {
                for result in results {
                    tracks.append(result)
                }
            }
            completed(tracks)
        }
    }
    
    public func getAllUserTracks(until: _DataTracks_, completed: @escaping (_DataTracks_) -> Void){
        deezer.getAllUserTracks(){ results in
            var tracks: _DataTracks_
            tracks = _DataTracks_(platform: .Deezer)
            if let results = results?.data {
                for result in results {
                    tracks.append(result)
                }
            }
            completed(tracks)
        }
    }
    
    public func updateHistory(tracks: _DataTracks_, completed: @escaping () -> Void) {
        self.getHistory(){ results in
            if results == tracks {
                completed()
            } else {
                tracks.copy(results)
            }
        }
    }
    
    public func getHistory(completed: @escaping (_DataTracks_) -> Void){
        deezer.getHistory(){ results in
            var tracks: _DataTracks_
            tracks = _DataTracks_(platform: .Deezer)
            if let results = results?.data {
                for result in results {
                    tracks.append(result)
                }
            }
            completed(tracks)
        }
    }
    
    public func getAllPlaylistsOfUser(user_id: String, completed: @escaping (_DataPlaylists_) -> Void){
        deezer.getAllPlaylistsOfUser(user_id: user_id){ results in
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
    
    public func getFollowing(completed: @escaping (_DataUsers_) -> Void) {
        deezer.getFollowing() { users in
            var datauser: _DataUsers_
            datauser = _DataUsers_(platform: .Deezer)

            if let users = users, let data = users.data {
                func processUser(index: Int) {
                    if index < data.count {
                        let user = data[index]
                        datauser.append(user)
                        if let url = user.picture {
                            self.deezer.getImageAlbum(coverURL: url) { image in
                                datauser.users[index].image = image
                                processUser(index: index + 1)
                            }
                        } else {
                            processUser(index: index + 1)
                        }
                    } else {
                        completed(datauser)
                    }
                }

                processUser(index: 0)
            } else {
                completed(datauser)
            }
        }
    }
    
}
