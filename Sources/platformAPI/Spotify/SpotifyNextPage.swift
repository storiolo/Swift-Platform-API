//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {
    //The first time this function is called, currentPage should be the page and nextpage should be empty
    func loadNextPage_Tracks(status_id: UUID, currentPage: URL?, previousPage: URL?, tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
        if currentPage == previousPage || currentPage == nil  {
            completed(tracks)
            return
        } else {
            loadNextPage_T(status_id: status_id, href: currentPage) { url, tracks_ in
                self.loadNextPage_Tracks(status_id: status_id, currentPage: url, previousPage: currentPage, tracks: tracks+tracks_){ result in
                    return
                } //current page become nextpage
            }
        }
    }
    
    func loadNextPage_User(status_id: UUID, currentPage: URL?, previousPage: URL?, tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
        if currentPage == previousPage || currentPage == nil  {
            completed(tracks)
            return
        } else {
            loadNextPage_T(status_id: status_id, href: currentPage) { url, tracks_ in
                self.loadNextPage_User(status_id: status_id, currentPage: url, previousPage: currentPage, tracks: tracks+tracks_, completed: completed) //current page become nextpage
            }
        }
    }
    
    func loadNextPage_User(status_id: UUID, currentPage: URL?, previousPage: URL?, tracks: [_track_], until: [_track_]? = nil, completed: @escaping ([_track_]) -> Void) {
        if currentPage == previousPage || currentPage == nil  {
            completed(tracks)
            return
        } else {
            loadNextPage_T(status_id: status_id, href: currentPage) { url, tracks_ in
                if let until = until{
                    var out: [_track_]
                    out = tracks
                    
                    for item in tracks_ {
                        if item.uri == until.first?.uri {
                            completed(out)
                            return
                        }
                        out.append(item)
                    }
                }
                self.loadNextPage_User(status_id: status_id, currentPage: url, previousPage: currentPage, tracks: tracks+tracks_, completed: completed) //current page become nextpage
            }
        }
    }
    
    
    func loadNextPage_T(status_id: UUID, href: URL?, completed: @escaping (URL?, [_track_]) -> Void) {
        var tracks: [_track_] = []
        guard let href = href else { return }
        api
            .getFromHref(href, responseType: PagingObject<SavedTrack>.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    self.arrStatus.set_count(id: status_id, ld_count: PlaylistTracks.offset)
                    let playlistItems_ = PlaylistTracks.items.map(\.item)
                    let playlistItems: [Track] = playlistItems_.compactMap { $0 }
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        tracks.append(_track_( playlistItem))
                    }
                    completed(PlaylistTracks.next, tracks)
                }
            )
            .store(in: &cancellables)
    }
    
    
    func loadNextPage(currentPage: URL?, previousPage: URL?, playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void) {
        if currentPage == previousPage || currentPage == nil  {
            completed(playlists)
            return
        } else {
            loadNextPage_P(href: currentPage) { url, playlists_ in
                self.loadNextPage(currentPage: url, previousPage: currentPage, playlists: playlists+playlists_){ result in
                    return
                } //current page become nextpage
            }
        }
    }
    func loadNextPage_P(href: URL?, completed: @escaping (URL?, [_playlist_]) -> Void) {
        var playlists: [_playlist_] = []
        
        guard let href = href else { return }
        api
            .getFromHref(href, responseType: PagingObject<Playlist<PlaylistItemsReference>>.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    for playlistsItem in playlistsPage.items {
                        playlists.append(_playlist_( playlistsItem))
                    }
                    completed(playlistsPage.next, playlists)
                }
            )
            .store(in: &cancellables)
    }
    
}
