//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI

public class _track_: ObservableObject, Identifiable {
    public var id = UUID()
    
    @Published public var title: String = ""
    @Published public var artist: String = ""
    @Published public var uri: String = ""
    @Published public var artist_uri: String = ""
    @Published public var preview_uri: String = ""
    @Published public var image_uri: String = ""
    @Published public var genres: String = ""
    @Published public var image: Image? = nil
    @Published public var platform: platform = .None
    
    public init() {}

    public init(_ track: Track) {
        self.title = track.name
        self.artist = track.artists?.first?.name ?? ""
        self.artist_uri = track.artists?.first?.uri ?? ""
        self.image_uri = track.album?.images?.largest?.url.absoluteString ?? ""
        self.uri = track.uri ?? ""
        self.platform = .Spotify
    }

    public init(_ track: DeezerTrack) {
        self.title = track.title ?? ""
        self.artist = track.artist?.name ?? ""
        self.artist_uri = String(track.artist?.id ?? 0)
        self.image_uri = track.album?.cover_xl ?? ""
        self.uri = "deezer:\(track.id ?? 0)"
        self.platform = .Deezer
    }
}
