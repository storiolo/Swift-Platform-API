//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    public func getUser(completed: @escaping (_user_) -> Void) {
        deezer.getUser(){ user in
            var datauser: _user_ = _user_()
            
            if let user = user {
                datauser = _user_(user)
                if let url = user.picture {
                    self.deezer.getImageAlbum(coverURL: url) { image in
                        datauser.image = image
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
    
    public func getUser(user_id: String, completed: @escaping (_user_) -> Void) {
        deezer.getaUser(user_id: user_id){ user in
            var datauser: _user_ = _user_()
            
            if let user = user {
                datauser = _user_(user)
                if let url = user.picture {
                    self.deezer.getImageAlbum(coverURL: url) { image in
                        datauser.image = image
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
    
    public func getUsers(user_ids: [String], completed: @escaping ([_user_]) -> Void) {
        _imb_(items: user_ids, fetch: getUser(user_id:completed:), completed: completed)
    }

    
    public func getUserCurrentSong(completed: @escaping (_track_) -> Void) {
        print("Not Available on Deezer")
        completed(_track_())
    }
    

     
    public func getHistory(completed: @escaping ([_track_]) -> Void){
        deezer.getHistory(){ results in
            var tracks: [_track_] = []
            if let results = results?.data {
                for result in results {
                    tracks.append(_track_( result))
                }
            }
            completed(tracks)
        }
    }
    
    
    public func getFollowing(completed: @escaping ([_user_]) -> Void) {
        deezer.getFollowing() { users in
            var datauser: [_user_] = []

            if let users = users, let data = users.data {
                func processUser(index: Int) {
                    if index < data.count {
                        let user = data[index]
                        datauser.append(_user_(user))
                        if let url = user.picture {
                            self.deezer.getImageAlbum(coverURL: url) { image in
                                datauser[index].image = image
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
