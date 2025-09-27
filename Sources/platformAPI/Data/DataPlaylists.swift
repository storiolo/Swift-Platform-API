//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI


public class _playlist_: ObservableObject, Identifiable {
    public var id = UUID()
    
    @Published public var title: String = ""
    @Published public var uri: String = ""
    @Published public var image_uri: String = ""
    @Published public var image: Image? = nil
    @Published public var creator_uri: String = ""
    @Published public var platform: platform = .None
    

    public init() {}

    public init(_ playlist: Playlist<PlaylistItemsReference>) {
        self.title = playlist.name
        self.uri = playlist.uri
        self.image_uri = playlist.images.largest?.url.absoluteString ?? ""
        self.creator_uri = playlist.owner?.uri ?? ""
        self.platform = .Spotify
    }

    public init(_ playlist: DeezerPlaylist) {
        self.title = playlist.title ?? ""
        self.uri = String(playlist.id ?? 0)
        self.image_uri = playlist.picture ?? ""
        self.creator_uri = String(playlist.creator?.id ?? 0)
        self.platform = .Deezer
    }
}

