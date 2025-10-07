//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {

    private func fetchImageUser(_ user: SpotifyUser, completed: @escaping (_user_) -> Void){
        var datauser: _user_
        datauser = _user_(user)
        if let url = user.images?[0].url {
            self.getImageUri(url){ image in
                datauser.image = image
                completed(datauser)
            }
        } else {
            completed(datauser)
        }
    }
    
    public func getUser(completed: @escaping (_user_) -> Void) {
        self.api.currentUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { user in
                    self.fetchImageUser(user, completed: completed)
                }
            )
            .store(in: &cancellables)
    }
    
    public func getUser(user_id: String, completed: @escaping (_user_) -> Void) {
        self.api.userProfile(user_id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { user in
                    self.fetchImageUser(user, completed: completed)
                }
            )
            .store(in: &cancellables)
    }
    
    
    
    
    public func getUsers(user_ids: [String], completed: @escaping ([_user_]) -> Void) {
        _imb_(items: user_ids, fetch: getUser(user_id:completed:), completed: completed)
    }

    
    

    
    
    public func getHistory(completed: @escaping ([_track_]) -> Void) {
        api.recentlyPlayed(limit: 5)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistTracks in
                    let tracks = playlistTracks.items.compactMap { item in
                        let track = item.track
                        return track.isLocal ? nil : _track_(track)
                    }
                    completed(tracks)
                }
            )
            .store(in: &self.cancellables)
    }

    
    public func getUserCurrentSong(completed: @escaping (_track_) -> Void) {
        self.api.currentPlayback()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { Song in
                    guard let Song = Song,
                          let uri = Song.item?.uri
                    else { completed(_track_()); return }
                    
                    self.getTrack(id: uri){ track in
                        completed(track)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
}
