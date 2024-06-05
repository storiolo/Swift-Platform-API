//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {
    public func getUser(completed: @escaping (_DataUsers_) -> Void) {
        self.api.currentUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { user in
                    var datauser: _DataUsers_
                    datauser = _DataUsers_(platform: .Spotify)
                    
                    if let url = user.images?[0].url {
                       datauser.append(user)
                        
                        let spotifyImage = SpotifyImage(url: url)
                        spotifyImage.load()
                            .receive(on: DispatchQueue.main)
                            .sink(
                                receiveCompletion: { _ in },
                                receiveValue: { image in
                                    datauser.users[0].image = image
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
    
    public func getUser(user_id: String, completed: @escaping (_DataUsers_) -> Void) {
        self.api.userProfile(user_id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { user in
                    var datauser: _DataUsers_
                    datauser = _DataUsers_(platform: .Spotify)
                    
                    if let url = user.images?[0].url {
                       datauser.append(user)
                        
                        let spotifyImage = SpotifyImage(url: url)
                        spotifyImage.load()
                            .receive(on: DispatchQueue.main)
                            .sink(
                                receiveCompletion: { _ in },
                                receiveValue: { image in
                                    datauser.users[0].image = image
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
    
    
    public func getAllUserPlaylists(completed: @escaping (_DataPlaylists_) -> Void) {
        var playlists: _DataPlaylists_
        playlists = _DataPlaylists_(platform: .Spotify)
        
        self.api.currentUserPlaylists(limit: 50)
            .extendPages(self.api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    for playlistsItem in playlistsPage.items {
                        playlists.append(playlistsItem)
                    }
                    
                    self.loadNextPage(currentPage: playlistsPage.next, previousPage: nil, playlists: playlists){ tracks_ in
                        completed(tracks_)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getAllUserTracks(completed: @escaping (_DataTracks_) -> Void) {
        var concatenatedTracks: _DataTracks_
        concatenatedTracks = _DataTracks_(platform: .Spotify)
        api.currentUserSavedTracks(limit: 50, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.item)
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        concatenatedTracks.append(playlistItem)
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
    
    public func getAllUserTracks(index: Int, completed: @escaping (_DataTracks_) -> Void) {
        var concatenatedTracks: _DataTracks_
        concatenatedTracks = _DataTracks_(platform: .Spotify)
        api.currentUserSavedTracks(limit: 50, offset: index)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.item)
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        concatenatedTracks.append(playlistItem)
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
    
    public func getAllUserTracks(until: _DataTracks_, completed: @escaping (_DataTracks_) -> Void) {
        var concatenatedTracks: _DataTracks_
        concatenatedTracks = _DataTracks_(platform: .Spotify)
        api.currentUserSavedTracks(limit: 50, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.item)
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        concatenatedTracks.append(playlistItem)

                        if playlistItem.uri == until.tracks.first?.uri {
                            for (it, item) in concatenatedTracks.tracks.enumerated() {
                                until.tracks.insert(item, at: it)
                            }
                            completed(until)
                            return
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
    
    
    public func updateHistory(tracks: _DataTracks_, completed: @escaping () -> Void) {
        self.getHistory(){ results in
            if results == tracks {
                completed()
            } else {
                tracks.copy(results)
            }
        }
    }
    public func getHistory(completed: @escaping (_DataTracks_) -> Void) {
        var tracks: _DataTracks_
        tracks = _DataTracks_(platform: .Spotify, name: "Recent")
        api.recentlyPlayed(limit: 5)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    let playlistItems = PlaylistTracks.items.map(\.track)
                    
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        tracks.append(playlistItem)
                    }
                    completed(tracks)
                }
            )
            .store(in: &self.cancellables)
    }
    
    
    public func getUserCurrentSong(lastTrack: _DataTracks_, completed: @escaping (_DataTracks_) -> Void) {
        var tracks: _DataTracks_
        tracks = _DataTracks_(platform: .Spotify, name: "Currently Playing")
        
        self.api.currentPlayback()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { Song in
                    guard let Song = Song,
                          let uri = Song.item?.uri
                    else { completed(tracks); return }
                    
                    //if track is the same as before don't continue
                    if lastTrack.tracks.first?.uri == uri {
                        completed(lastTrack)
                        return
                    }
                    
                    self.getTrack(uri: uri){ track in
                        tracks.tracks.append(track)
                        completed(tracks)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getAllPlaylistsOfUser(user_id: String, completed: @escaping (_DataPlaylists_) -> Void) {
        var playlists: _DataPlaylists_
        playlists = _DataPlaylists_(platform: .Spotify)
        
        self.api.userPlaylists(for: user_id)
            .extendPages(self.api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    for playlistsItem in playlistsPage.items {
                        playlists.append(playlistsItem)
                    }
                    
                    self.loadNextPage(currentPage: playlistsPage.next, previousPage: nil, playlists: playlists){ tracks_ in
                        completed(tracks_)
                    }
                    
                    completed(playlists)
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func getFollowing(completed: @escaping (_DataUsers_) -> Void) {
        print("Not Available on Spotify")
        completed(_DataUsers_(platform: .Spotify))
    }
}
