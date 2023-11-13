//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI


public class _DataTracks_: ObservableObject {
    public var platform: platform
    public var name: String
    public var uri: String
    @Published public var tracks: [_track_] = []
    
    public struct _track_: Identifiable {
        public var id = UUID()
        
        //Saved
        public var title: String
        public var artist: String
        public var uri: String
        public var artist_uri: String
        public var preview_uri: String
        public var image_uri: String
        public var genres: String
        
        //Others
        public var image: Image?
        
        //Only available on Spotify
        public var features: AudioFeatures?
        public var analysis: AudioAnalysis?
        
        public init(track: Track){
            self.title = track.name
            self.artist = track.artists?.first?.name ?? ""
            self.artist_uri = track.artists?.first?.uri ?? ""
            self.image_uri = track.album?.images?.largest?.url.absoluteString ?? ""
            self.uri = track.uri ?? ""
            self.image = nil
            self.genres = ""
            self.features = nil
            self.analysis = nil
            self.preview_uri = track.previewURL?.absoluteString ?? ""
        }
        
        public init(track: DeezerTrack){
            self.title = track.title ?? ""
            self.artist = track.artist?.name ?? ""
            self.artist_uri = String(track.artist?.id ?? 0)
            self.image_uri = track.album?.cover_xl ?? ""
            self.uri = String(track.id ?? 0)
            self.image = nil
            self.genres = ""
            self.features = nil
            self.analysis = nil
            self.preview_uri = track.preview ?? ""
        }
        
        public init(title: String, artist: String, uri: String, artist_uri: String, preview_uri: String, image_uri: String, genres: String){
            self.title = title
            self.artist = artist
            self.artist_uri = artist_uri
            self.image_uri = image_uri
            self.uri = uri
            self.image = nil
            self.genres = genres
            self.features = nil
            self.analysis = nil
            self.preview_uri = preview_uri
        }
    }
    
    
    public init(platform: platform, name: String = "None", uri: String = "") {
        self.platform = platform
        self.name = name
        self.uri = uri
    }
    
    
    //<<---- OPERATORS ---->>\\
    public static func ==(left: _DataTracks_, right: _DataTracks_) -> Bool {
        guard left.tracks.count == right.tracks.count else {
            return false
        }
        for (leftTrack, rightTrack) in zip(left.tracks, right.tracks) {
            if leftTrack.uri != rightTrack.uri {
                return false
            }
        }
        return true
    }
    public static func +=(left: inout _DataTracks_, right: _DataTracks_) {
        left.tracks += right.tracks
    }
    public static func +(left: _DataTracks_, right: _DataTracks_) -> _DataTracks_ {
        let out = left
        out.tracks += right.tracks
        return out
    }
    public func append(_ track: Track) {
        self.tracks.append(_track_(track: track))
    }
    public func append(_ track: DeezerTrack) {
        self.tracks.append(_track_(track: track))
    }
    public func copy(_ right: _DataTracks_) {
        self.tracks = right.tracks
        self.platform = right.platform
        self.name = right.name
        self.uri = right.uri
    }
    public func isIn(_ track: _track_) -> Bool {
        for item in self.tracks {
            if item.uri == track.uri {
                return true
            }
        }
        return false
    }
    
    public func isIn(_ track_id: String) -> Bool {
        for item in self.tracks {
            if item.uri == track_id {
                return true
            }
        }
        return false
    }
    
    
    
    //<<---- SAVE ---->>\\
    public func saveDatabase() {
        let trackProperties = ["title", "artist", "uri", "artist_uri", "preview_uri", "image_uri", "genres"]
        for property in trackProperties {
            let values = tracks.map { $0[keyPath: \.self] }
            UserDefaults.standard.set(values, forKey: property)
        }
        UserDefaults.standard.set(self.platform.rawValue, forKey: "platform")
        print("Data Saved!")
    }
    
    public func loadDatabase(completed: @escaping () -> Void) {
        guard let platform = UserDefaults.standard.string(forKey: "platform"),
              let title = UserDefaults.standard.array(forKey: "title") as? [String],
              let artist = UserDefaults.standard.array(forKey: "artist") as? [String],
              let uri = UserDefaults.standard.array(forKey: "uri") as? [String],
              let artist_uri = UserDefaults.standard.array(forKey: "artist_uri") as? [String],
              let preview_uri = UserDefaults.standard.array(forKey: "preview_uri") as? [String],
              let image_uri = UserDefaults.standard.array(forKey: "image_uri") as? [String],
              let genres = UserDefaults.standard.array(forKey: "genres") as? [String] else {
            completed()
            return
        }
        
        tracks = []
        self.name = "DataBase"
        self.platform = platform == "Spotify" ? .Spotify : .Deezer
        for i in 0..<artist.count {
            tracks.append(_track_(title: title[i], artist: artist[i], uri: uri[i],
                                artist_uri: artist_uri[i], preview_uri: preview_uri[i], image_uri: image_uri[i], genres: genres[i]))
        }
        completed()
        
        print("Data Loaded!")
    }
    
}

