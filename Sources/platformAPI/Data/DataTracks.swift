//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI


public struct _track_: Identifiable {
    public var id = UUID()
    
    public var title: String
    public var artist: String
    public var uri: String
    public var artist_uri: String
    public var preview_uri: String
    public var image_uri: String
    public var genres: String
    public var image: Image?
    public var platform: platform
    
    public init(_ track: Track){
        self.title = track.name
        self.artist = track.artists?.first?.name ?? ""
        self.artist_uri = track.artists?.first?.uri ?? ""
        self.image_uri = track.album?.images?.largest?.url.absoluteString ?? ""
        self.uri = track.uri ?? ""
        self.image = nil
        self.genres = ""
        self.preview_uri = track.previewURL?.absoluteString ?? ""
        self.platform = .Spotify
    }
    
    public init(_ track: DeezerTrack){
        self.title = track.title ?? ""
        self.artist = track.artist?.name ?? ""
        self.artist_uri = String(track.artist?.id ?? 0)
        self.image_uri = track.album?.cover_xl ?? ""
        self.uri = String(track.id ?? 0)
        self.image = nil
        self.genres = ""
        self.preview_uri = track.preview ?? ""
        self.platform = .Deezer
    }
    
    public init(){
        self.title = ""
        self.artist = ""
        self.artist_uri = ""
        self.image_uri = ""
        self.uri = ""
        self.image = nil
        self.genres = ""
        self.preview_uri = ""
        self.platform = .None
    }
}

