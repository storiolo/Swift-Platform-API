//  playlify
//
//  Created by Nicolas Storiolo on 23/10/2023.
//

import Foundation
import SpotifyWebAPI

extension _SpotifyAPI_ {

    public func loadNext(tracks: [_track_], url: URL?, completed: @escaping ([_track_], URL?) -> Void){
        guard let url = url else {
            completed(tracks, nil)
            return
        }
        
        api.getFromHref(url, responseType: PagingObject<SavedTrack>.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { PlaylistTracks in
                    var newTracks = tracks
                    newTracks.append(contentsOf:PlaylistTracks.items
                                            .map(\.item)
                                            .filter { !$0.isLocal }
                                            .map { _track_($0) }
                                    )

                    completed(newTracks, PlaylistTracks.next)
                }
            )
            .store(in: &cancellables)
    }
    
    
    public func loadNext(playlists: [_playlist_], url: URL?, completed: @escaping ([_playlist_], URL?) -> Void){
        guard let url = url else {
            completed(playlists, nil)
            return
        }
        
        api.getFromHref(url, responseType: PagingObject<Playlist<PlaylistItemsReference>>.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { playlistsPage in
                    var newplaylists = playlists
                    newplaylists.append(contentsOf: playlistsPage.items.map { _playlist_($0) })
                    completed(newplaylists, playlistsPage.next)
                }
            )
            .store(in: &cancellables)
    }
    
}
