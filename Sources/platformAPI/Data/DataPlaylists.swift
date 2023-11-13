//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI


public class _DataPlaylists_: ObservableObject {
    public var platform: platform
    @Published public var playlists: [_playlist_] = []
    
    public struct _playlist_: Identifiable {
        public var id = UUID()
        
        public var title: String
        public var uri: String
        public var image_uri: String
        public var image: Image?
        public var creator_uri: String
        
        public init(playlist: Playlist<PlaylistItemsReference>){
            self.title = playlist.name
            self.uri = playlist.uri
            self.image_uri = playlist.images.largest?.url.absoluteString ?? ""
            self.image = nil
            self.creator_uri = playlist.owner?.uri ?? ""
        }
        
        public init(playlist: DeezerPlaylist){
            self.title = playlist.title ?? ""
            self.uri = String(playlist.id ?? 0)
            self.image_uri = playlist.picture ?? ""
            self.image = nil
            self.creator_uri = String(playlist.creator?.id ?? 0)
        }
        
    }
    
    public init(platform: platform) {
        self.platform = platform
    }
    
    
    //<<---- OPERATORS ---->>\\
    public static func +=(left: inout _DataPlaylists_, right: _DataPlaylists_) {
        left.playlists += right.playlists
    }
    public static func +(left: _DataPlaylists_, right: _DataPlaylists_) -> _DataPlaylists_ {
        let out = left
        out.playlists += right.playlists
        return out
    }
    public func append(_ playlist: Playlist<PlaylistItemsReference>) {
        self.playlists.append(_playlist_(playlist: playlist))
    }
    public func append(_ playlist: DeezerPlaylist) {
        self.playlists.append(_playlist_(playlist: playlist))
    }
    public func copy(_ right: _DataPlaylists_) {
        self.playlists = right.playlists
        self.platform = right.platform
    }
    
    //<<---- TOOLS ---->>\\
    public func search(search: String) -> _DataPlaylists_ {
        if search.isEmpty {
            return self
        }
        
        let new = _DataPlaylists_(platform: self.platform)
        for playlist in playlists {
            if playlist.title.lowercased().contains(search.lowercased()) {
                new.playlists.append(playlist)
            }
        }
        return new
    }
}
