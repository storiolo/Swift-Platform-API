//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {

    public func getUser(completed: @escaping (_user_) -> Void) {
        self.api.currentUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { user in
                    var datauser: _user_
                    datauser = _user_(user)
                    
                    if let url = user.images?[0].url {
                        let spotifyImage = SpotifyImage(url: url)
                        spotifyImage.load()
                            .receive(on: DispatchQueue.main)
                            .sink(
                                receiveCompletion: { _ in },
                                receiveValue: { image in
                                    datauser.image = image
                                    completed(datauser)
                                }
                            )
                            .store(in: &self.cancellables)
                    } else {
                        completed(datauser)
                    }
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
                    var datauser: _user_
                    datauser = _user_(user)
                    
                    if let url = user.images?[0].url {
                        let spotifyImage = SpotifyImage(url: url)
                        spotifyImage.load()
                            .receive(on: DispatchQueue.main)
                            .sink(
                                receiveCompletion: { _ in },
                                receiveValue: { image in
                                    datauser.image = image
                                    completed(datauser)
                                }
                            )
                            .store(in: &self.cancellables)
                    } else {
                        completed(datauser)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getUsers(user_ids: [String], completed: @escaping ([_user_]) -> Void) {
        var dataUsers: [_user_] = []

        openNextUser(currentIndex: 0)
        func openNextUser(currentIndex: Int){
            guard currentIndex < user_ids.count else {
                completed(dataUsers)
                return
            }
            
            getUser(user_id: user_ids[currentIndex]){ result in
                dataUsers.append(result)
                openNextUser(currentIndex: currentIndex+1)
            }
        }
    }

    
    
    
    
    public func getAllUserPlaylists(completed: @escaping ([_playlist_]) -> Void) {
        var playlists: [_playlist_] = []
        
        self.api.currentUserPlaylists(limit: 50)
            .extendPages(self.api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    for playlistsItem in playlistsPage.items {
                        playlists.append(_playlist_( playlistsItem))
                    }
                    
                    self.loadNextPage(currentPage: playlistsPage.next, previousPage: nil, playlists: playlists){ tracks_ in
                        completed(tracks_)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getAllUserTracks(completed: @escaping ([_track_]) -> Void) {
        var concatenatedTracks: [_track_] = []
        api.currentUserSavedTracks(limit: 50, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.item)
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        concatenatedTracks.append(_track_( playlistItem))
                    }
                    
                    let status_id = self.arrStatus.add_status(text: "Loading Songs", ld_max: PlaylistTracks.total)
                    self.loadNextPage_User(status_id: status_id, currentPage: PlaylistTracks.next, previousPage: nil, tracks: concatenatedTracks){ tracks_ in
                        self.arrStatus.delete_status(id: status_id)
                        completed(tracks_)
                    }
                }
            )
            .store(in: &self.cancellables)
    }
    
    public func getAllUserTracks(index: Int, completed: @escaping ([_track_]) -> Void) {
        var concatenatedTracks: [_track_] = []
        api.currentUserSavedTracks(limit: 50, offset: index)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.item)
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        concatenatedTracks.append(_track_( playlistItem))
                    }
                    
                    let status_id = self.arrStatus.add_status(text: "Loading Songs", ld_max: PlaylistTracks.total)
                    self.loadNextPage_User(status_id: status_id, currentPage: PlaylistTracks.next, previousPage: nil, tracks: concatenatedTracks){ tracks_ in
                        self.arrStatus.delete_status(id: status_id)
                        completed(tracks_)
                    }
                }
            )
            .store(in: &self.cancellables)
    }
    
    public func getAllUserTracks(until: [_track_], completed: @escaping ([_track_]) -> Void) {
        var concatenatedTracks: [_track_] = []
        api.currentUserSavedTracks(limit: 50, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.item)
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }

                        if playlistItem.uri == until.first?.uri {
                            completed(concatenatedTracks)
                            return
                        } else {
                            concatenatedTracks.append(_track_( playlistItem))
                        }
                    }
                    
                    let status_id = self.arrStatus.add_status(text: "Loading Songs", ld_max: PlaylistTracks.total)
                    self.loadNextPage_User(status_id: status_id, currentPage: PlaylistTracks.next, previousPage: nil, tracks: concatenatedTracks, until: until){ tracks_ in
                        self.arrStatus.delete_status(id: status_id)
                        completed(tracks_)
                    }
                }
            )
            .store(in: &self.cancellables)
    }
    
    
    public func getHistory(completed: @escaping ([_track_]) -> Void) {
        var tracks: [_track_] = []
        api.recentlyPlayed(limit: 5)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.track)
                    
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        tracks.append(_track_( playlistItem))
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
    
    
    public func getAllPlaylistsOfUser(user_id: String, completed: @escaping ([_playlist_]) -> Void) {
        var playlists: [_playlist_] = []
        
        self.api.userPlaylists(for: user_id)
            .extendPages(self.api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    for playlistsItem in playlistsPage.items {
                        playlists.append(_playlist_( playlistsItem))
                    }
                    
                    self.loadNextPage(currentPage: playlistsPage.next, previousPage: nil, playlists: playlists){ tracks_ in
                        completed(tracks_)
                    }
                    
                    completed(playlists)
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getFollowing(completed: @escaping ([_user_]) -> Void) {
        print("Not Available on Spotify")
        completed([_user_]())
    }
}
