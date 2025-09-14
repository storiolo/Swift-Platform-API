//  playlify
//
//  Created by Nicolas Storiolo on 24/10/2023.
//

import Foundation
import SwiftUI

public enum platform: String, CaseIterable {
    case None
    case Deezer
    case Spotify
}

public protocol API {
    //<<---- API ---->>\\
    func isConnected() -> Bool
    func isDisconnected() -> Bool
    func isTryingtoConnect() -> Bool
    func disconnect()
    func getPlatform() -> platform
    
    //only used in spotify and for NextPage
    func getfuncStatus() -> [_arrStatus_._Status_]
    
    
    //<<---- Search ---->>\\
    func SearchPlaylist(search: String, max: Int, completed: @escaping ([_playlist_]) -> Void)
    func SearchPlaylist(search: String, completed: @escaping ([_playlist_]) -> Void)
    func SearchTrack(search: String, completed: @escaping ([_track_]) -> Void)
    func SearchUser(search: String, completed: @escaping ([_user_]) -> Void)
    
    
    //<<---- User ---->>\\
    func getUser(completed: @escaping (_user_) -> Void)
    func getUser(user_id: String, completed: @escaping (_user_) -> Void)
    func getUsers(user_ids: [String], completed: @escaping ([_user_]) -> Void)
    func getAllUserPlaylists(completed: @escaping ([_playlist_]) -> Void)
    func getUserCurrentSong(completed: @escaping (_track_) -> Void)
    func getAllUserTracks(completed: @escaping ([_track_]) -> Void)
    func getAllUserTracks(index: Int, completed: @escaping ([_track_]) -> Void)
    func getAllUserTracks(until: [_track_], completed: @escaping ([_track_]) -> Void)
    func getHistory(completed: @escaping ([_track_]) -> Void)
    func getAllPlaylistsOfUser(user_id: String, completed: @escaping ([_playlist_]) -> Void)
    func getFollowing(completed: @escaping ([_user_]) -> Void)
    
    
    //<<---- Track ---->>\\
    func getAllTracks(playlist_id: String, completed: @escaping ([_track_]) -> Void)
    func getTrack(id: String, completed: @escaping (_track_) -> Void)
    func getTracks(id: [String], completed: @escaping ([_track_]) -> Void)
    
    
    //<<---- Misc ---->>\\
    func getImageAlbum(track: _track_, completed: @escaping (Image?) -> Void)
    func getImageAlbum(track: _track_, completed: @escaping (_track_) -> Void)
    func getImageAlbum(tracks: [_track_], completed: @escaping ([_track_]) -> Void)
    func getImageAlbum(playlist: _playlist_, completed: @escaping (Image?) -> Void)
    func getImageAlbum(playlist: _playlist_, completed: @escaping (_playlist_) -> Void)
    func getImageAlbum(playlists: [_playlist_], completed: @escaping ([_playlist_]) -> Void)
    
    
    //<<---- AddPlaylist ---->>\\
    func createPlaylist(title: String, completed: @escaping (String) -> Void)
    func addTracksToPlaylist(playlist_id: String, tracks_id: [String], completed: @escaping (Bool) -> Void)
    func addTracksToFavorite(track_id: String, completed: @escaping (Bool) -> Void)
    
    
    //<<---- Player ---->>\\
    func Play()
    func Pause()
    func Next()
    func Previous()
    func UserQueue(completed: @escaping ([_track_]) -> Void)
    func AddToUserQueue(track_id: String)
    func Play(tracks_id: [String])
    func Play(track_id: String)
    
}
