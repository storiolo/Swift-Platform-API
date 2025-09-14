//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI


public struct _playlist_: Identifiable {
    public var id = UUID()
    
    public var title: String
    public var uri: String
    public var image_uri: String
    public var image: Image?
    public var creator_uri: String
    public var platform: platform
    
    public init(_ playlist: Playlist<PlaylistItemsReference>){
        self.title = playlist.name
        self.uri = playlist.uri
        self.image_uri = playlist.images.largest?.url.absoluteString ?? ""
        self.image = nil
        self.creator_uri = playlist.owner?.uri ?? ""
        self.platform = .Spotify
    }
    
    public init(_ playlist: DeezerPlaylist){
        self.title = playlist.title ?? ""
        self.uri = String(playlist.id ?? 0)
        self.image_uri = playlist.picture ?? ""
        self.image = nil
        self.creator_uri = String(playlist.creator?.id ?? 0)
        self.platform = .Deezer
    }
    
    public init(){
        self.title = ""
        self.uri = ""
        self.image_uri = ""
        self.image = nil
        self.creator_uri = ""
        self.platform = .None
    }
}
