//  playlify
//
//  Created by Nicolas Storiolo on 25/10/2023.
//

import Foundation
import SwiftUI

public class _NoAPI_: ObservableObject, API {
    public init() {}
    
    //<<---- API ---->>\\
    public func isConnected() -> Bool {
        print("API: No API Selected")
        return false
    }

    public func isDisconnected() -> Bool {
        print("API: No API Selected")
        return true
    }

    public func isTryingtoConnect() -> Bool {
        print("API: No API Selected")
        return false
    }

    public func disconnect() {
        print("API: No API Selected")
    }

    public func getPlatform() -> platform {
        print("API: No API Selected")
        return .None
    }

    //<<---- Search ---->>\\
    public func SearchPlaylist(search: String, completed: @escaping ([_playlist_]) -> Void) {
        print("API: No API Selected")
        completed([])
    }

    public func SearchTrack(search: String, completed: @escaping ([_track_]) -> Void) {
        print("API: No API Selected")
        completed([])
    }


    //<<---- User ---->>\\
    public func getUser(completed: @escaping (_user_) -> Void) {
        print("API: No API Selected")
        completed(_user_())
    }

    public func getUser(user_id: String, completed: @escaping (_user_) -> Void) {
        print("API: No API Selected")
        completed(_user_())
    }

    public func getUsers(user_ids: [String], completed: @escaping ([_user_]) -> Void) {
        print("API: No API Selected")
        completed([])
    }

    public func getUserCurrentSong(completed: @escaping (_track_) -> Void) {
        print("API: No API Selected")
        completed(_track_())
    }

    public func getHistory(completed: @escaping ([_track_]) -> Void) {
        print("API: No API Selected")
        completed([])
    }


    //<<---- Playlist ---->>\\
    public func getUserPlaylists(completed: @escaping ([_playlist_], URL?) -> Void) {
        print("API: No API Selected")
        completed([], nil)
    }

    public func getPlaylistsOfUser(user_id: String, completed: @escaping ([_playlist_], URL?) -> Void) {
        print("API: No API Selected")
        completed([], nil)
    }

    //<<---- Track ---->>\\
    public func getUserTracks(completed: @escaping ([_track_], URL?) -> Void) {
        print("API: No API Selected")
        completed([], nil)
    }

    public func getTracks(playlist_id: String, completed: @escaping ([_track_], URL?) -> Void) {
        print("API: No API Selected")
        completed([], nil)
    }

    public func getTrack(id: String, completed: @escaping (_track_) -> Void) {
        print("API: No API Selected")
        completed(_track_())
    }

    public func getTracks(id: [String], completed: @escaping ([_track_]) -> Void) {
        print("API: No API Selected")
        completed([])
    }

    //<<---- Misc ---->>\\
    public func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void) {
        print("API: No API Selected")
        completed(nil)
    }

    public func getImageAlbum(track: _track_, completed: @escaping (_track_) -> Void) {
        print("API: No API Selected")
        completed(track)
    }

    public func getImageAlbum(tracks: [_track_], completed: @escaping ([_track_]) -> Void) {
        print("API: No API Selected")
        completed(tracks)
    }

    public func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void) {
        print("API: No API Selected")
        completed(nil)
    }

    public func getImageAlbum(playlist: _playlist_, completed: @escaping (_playlist_) -> Void) {
        print("API: No API Selected")
        completed(playlist)
    }

    public func getImageAlbum(playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void) {
        print("API: No API Selected")
        completed(playlists)
    }

    //<<---- AddPlaylist ---->>\\
    public func createPlaylist(title: String, completed: @escaping (String) -> Void) {
        print("API: No API Selected")
        completed("")
    }

    public func addTracksToPlaylist(playlist_id: String, tracks_id: [String], completed: @escaping (Bool) -> Void) {
        print("API: No API Selected")
        completed(false)
    }

    public func addTracksToFavorite(track_id: String, completed: @escaping (Bool) -> Void) {
        print("API: No API Selected")
        completed(false)
    }

    //<<---- Player ---->>\\
    public func Play() {
        print("API: No API Selected")
    }

    public func Pause() {
        print("API: No API Selected")
    }

    public func Next() {
        print("API: No API Selected")
    }

    public func Previous() {
        print("API: No API Selected")
    }

    public func UserQueue(completed: @escaping ([_track_]) -> Void) {
        print("API: No API Selected")
        completed([])
    }

    public func AddToUserQueue(track_id: String) {
        print("API: No API Selected")
    }

    public func Play(tracks_id: [String]) {
        print("API: No API Selected")
    }

    public func Play(track_id: String) {
        print("API: No API Selected")
    }
    
    //<<---- Next ---->>\\
    public func loadNext(tracks: [_track_], url: URL?, completed: @escaping ([_track_], URL?) -> Void) {
        print("API: No API Selected")
        completed([], nil)
    }
    
    public func loadNext(playlists: [_playlist_], url: URL?, completed: @escaping ([_playlist_], URL?) -> Void) {
        print("API: No API Selected")
        completed([], nil)
    }
}
