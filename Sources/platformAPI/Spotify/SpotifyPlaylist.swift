//
//  SpotifyPlaylist.swift
//  platformAPI
//
//  Created by Nicolas Storiolo on 03/10/2025.
//

import Foundation
import SpotifyWebAPI
import Combine

extension _SpotifyAPI_ {
    
    private func fetchPlaylists(
        _ request: AnyPublisher<PagingObject<Playlist<PlaylistItemsReference>>, Error>,
        completed: @escaping ([_playlist_], URL?) -> Void
    ) {
        request
            .extendPages(self.api)
            .map { page in (page.items.map { _playlist_($0) }, page.next) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: completed)
            .store(in: &cancellables)
    }
    
    public func getUserPlaylists(completed: @escaping ([_playlist_], URL?) -> Void) {
        fetchPlaylists(self.api.currentUserPlaylists(limit: 50), completed: completed)
    }

    public func getPlaylistsOfUser(user_id: String, completed: @escaping ([_playlist_], URL?) -> Void) {
        fetchPlaylists(self.api.userPlaylists(for: user_id), completed: completed)
    }
}
