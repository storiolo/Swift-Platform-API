//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    
    private func fetchImageUser(_ user: DeezerUser, completed: @escaping (_user_) -> Void){
        var datauser: _user_
        datauser = _user_(user)
        if let url = user.picture {
            self.deezer.getImageAlbum(coverURL: url) { image in
                datauser.image = image
                completed(datauser)
            }
        } else {
            completed(datauser)
        }
    }
    
    
    public func getUser(completed: @escaping (_user_) -> Void) {
        deezer.getUser(){ user in
            guard let user = user else { completed(_user_()); return }
            self.fetchImageUser(user, completed: completed)
        }
    }
    
    public func getUser(user_id: String, completed: @escaping (_user_) -> Void) {
        let user_id = user_id.replacingOccurrences(of: "deezer:", with: "")
        deezer.getaUser(user_id: user_id){ user in
            guard let user = user else { completed(_user_()); return }
            self.fetchImageUser(user, completed: completed)
        }
    }
    
    public func getUsers(user_ids: [String], completed: @escaping ([_user_]) -> Void) {
        _imb_(items: user_ids, fetch: getUser(user_id:completed:), completed: completed)
    }

    public func getUserCurrentSong(completed: @escaping (_track_) -> Void) {
        deezer.getCurrentSong() { results in
            if let first = results?.data?.first {
                completed(_track_(first))
            } else {
                completed(_track_())
            }
        }
    }
    
    public func getHistory(completed: @escaping ([_track_]) -> Void){
        deezer.getHistory { results in
            let tracks = results?.data?.map { _track_($0) } ?? []
            completed(tracks)
        }
    }
    
    
}
