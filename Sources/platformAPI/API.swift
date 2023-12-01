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
    func getfuncStatus() -> (Bool, Int, Int)
    
    
    //<<---- Search ---->>\\
    func SearchPlaylist(search: String, max: Int, completed: @escaping (_DataPlaylists_) -> Void)
    func SearchPlaylist(search: String, completed: @escaping (_DataPlaylists_) -> Void)
    func SearchTrack(search: String, completed: @escaping (_DataTracks_) -> Void)
    func SearchUser(search: String, completed: @escaping (_DataUsers_) -> Void)
    
    
    //<<---- User ---->>\\
    func getUser(completed: @escaping (_DataUsers_) -> Void)
    func getUser(user_id: String, completed: @escaping (_DataUsers_) -> Void)
    func getAllUserPlaylists(completed: @escaping (_DataPlaylists_) -> Void)
    func getUserCurrentSong(lastTrack: _DataTracks_, completed: @escaping (_DataTracks_) -> Void)
    func getAllUserTracks(completed: @escaping (_DataTracks_) -> Void)
    func updateHistory(tracks: _DataTracks_, completed: @escaping () -> Void)
    func getHistory(completed: @escaping (_DataTracks_) -> Void)
    func getAllPlaylistsOfUser(user_id: String, completed: @escaping (_DataPlaylists_) -> Void)
    func getFollowing(completed: @escaping (_DataUsers_) -> Void)
    
    
    //<<---- Track ---->>\\
    func getAllTracks(playlist_id: String, completed: @escaping (_DataTracks_) -> Void)
    func getTrack(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void)
    
    
    //<<---- Misc ---->>\\
    func getImageAlbum(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void)
    func getImageAlbum(playlists: _DataPlaylists_, index: Int, completed: @escaping () -> Void)
    func getPlaylist(playlist_id: String, completed: @escaping (_DataPlaylists_) -> Void)
        //Not available in Deezer
    func getSongGenres(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void)
    func getSongInfo(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void)
    func getSongAnalysis(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void)
    
    
    //<<---- AddPlaylist ---->>\\
    func createPlaylist(title: String, completed: @escaping (String) -> Void)
    func addTracksToPlaylist(playlist_id: String, tracks_id: [String], completed: @escaping (Bool) -> Void)
    func addTracksToFavorite(track_id: String, completed: @escaping (Bool) -> Void)
    
    
    //<<---- Player ---->>\\
    func Play()
    func Pause()
    func Next()
    func Previous()
    func UserQueue(completed: @escaping (_DataTracks_) -> Void)
    func AddToUserQueue(track_id: String)
    func Play(tracks_id: [String])
    
}
