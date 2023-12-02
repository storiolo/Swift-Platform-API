//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {
    //The first time this function is called, currentPage should be the page and nextpage should be empty
    func loadNextPage(currentPage: URL?, previousPage: URL?, tracks: _DataTracks_, completed: @escaping (_DataTracks_) -> Void) {
        self.isLoading = true
        if currentPage == previousPage || currentPage == nil  {
            self.isLoading = false
            print("end Pages")
            completed(tracks)
            return
        } else {
            loadNextPage_T(href: currentPage) { url, tracks_ in
                self.loadNextPage(currentPage: url, previousPage: currentPage, tracks: tracks+tracks_){ result in
                    return
                } //current page become nextpage
            }
        }
    }
    func loadNextPage_T(href: URL?, completed: @escaping (URL?, _DataTracks_) -> Void) {
        var tracks: _DataTracks_
        tracks = _DataTracks_(platform: .Spotify)
        guard let href = href else { return }
        api
            .getFromHref(href, responseType: PagingObject<SavedTrack>.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    self.ld_max = PlaylistTracks.total
                    self.ld_count = PlaylistTracks.offset
                    let playlistItems_ = PlaylistTracks.items.map(\.item)
                    let playlistItems: [Track] = playlistItems_.compactMap { $0 }
                    for playlistItem in playlistItems {
                        if playlistItem.isLocal { continue }
                        tracks.append(playlistItem)
                    }
                    completed(PlaylistTracks.next, tracks)
                }
            )
            .store(in: &cancellables)
    }
    
    
    func loadNextPage(currentPage: URL?, previousPage: URL?, playlists: _DataPlaylists_, completed: @escaping (_DataPlaylists_) -> Void) {
        self.isLoading = true
        if currentPage == previousPage || currentPage == nil  {
            self.isLoading = false
            completed(playlists)
            return
        } else {
            loadNextPage_P(href: currentPage) { url, playlists_ in
                self.loadNextPage(currentPage: url, previousPage: currentPage, playlists: playlists+playlists_){ result in } //current page become nextpage
            }
        }
    }
    func loadNextPage_P(href: URL?, completed: @escaping (URL?, _DataPlaylists_) -> Void) {
        var playlists: _DataPlaylists_
        playlists = _DataPlaylists_(platform: .Spotify)
        guard let href = href else { return }
        api
            .getFromHref(href, responseType: PagingObject<Playlist<PlaylistItemsReference>>.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    self.ld_max = playlistsPage.total
                    self.ld_count = playlistsPage.offset
                    for playlistsItem in playlistsPage.items {
                        playlists.append(playlistsItem)
                    }
                    completed(playlistsPage.next, playlists)
                }
            )
            .store(in: &cancellables)
    }
    
}
