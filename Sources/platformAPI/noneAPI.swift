//  playlify
//
//  Created by Nicolas Storiolo on 25/10/2023.
//

import Foundation

public class _NoAPI_: ObservableObject, API {
    public func getPlatform() -> platform {
        return .None
    }
    public init(){
        
    }
    
    public func getAllUserPlaylists(completed: @escaping (_DataPlaylists_) -> Void) {
        print("API: No API Selected")
        completed(_DataPlaylists_(platform: .None))
    }
    
    public func getUserCurrentSong(lastTrack: _DataTracks_, completed: @escaping (_DataTracks_) -> Void) {
        print("API: No API Selected")
        completed(_DataTracks_(platform: .None))
    }
    
    public func getAllPlaylistsOfUser(user_id: String, completed: @escaping (_DataPlaylists_) -> Void) {
        print("API: No API Selected")
        completed(_DataPlaylists_(platform: .None))
    }
    
    public func getFollowing(completed: @escaping (_DataUsers_) -> Void) {
        print("API: No API Selected")
        completed(_DataUsers_(platform: .None))
    }
    
    public func getTrack(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("API: No API Selected")
    }
    
    public func getImageAlbum(playlists: _DataPlaylists_, index: Int, completed: @escaping () -> Void) {
        print("API: No API Selected")
    }
    
    public func getSongGenres(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("API: No API Selected")
    }
    
    public func getSongInfo(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("API: No API Selected")
    }
    
    public func getSongAnalysis(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("API: No API Selected")
    }
    
    public func addTracksToFavorite(track_id: String, completed: @escaping (Bool) -> Void) {
        print("API: No API Selected")
        completed(true)
    }
    
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
    
    public func UserQueue(completed: @escaping (_DataTracks_) -> Void) {
        print("API: No API Selected")
    }
    
    public func AddToUserQueue(track_id: String) {
        print("API: No API Selected")
    }
    
    public func Play(tracks_id: [String]){
        print("API: No API Selected")
    }
    
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
    
    public func getUser(completed: @escaping (_DataUsers_) -> Void) {
        print("API: No API Selected")
        completed(_DataUsers_(platform: .None))
    }
    
    public func getUser(user_id: String, completed: @escaping (_DataUsers_) -> Void) {
        print("API: No API Selected")
        completed(_DataUsers_(platform: .None))
    }
    
    public func getUserPlaylists(completed: @escaping (_DataPlaylists_) -> Void) {
        print("API: No API Selected")
        completed(_DataPlaylists_(platform: .None))
    }
    
    public func getAllTracks(playlist_id: String, completed: @escaping (_DataTracks_) -> Void) {
        print("API: No API Selected")
        completed(_DataTracks_(platform: .None))
    }
    
    public func getAllUserTracks(completed: @escaping (_DataTracks_) -> Void) {
        print("API: No API Selected")
        completed(_DataTracks_(platform: .None))
    }
    
    public func updateHistory(tracks: _DataTracks_, completed: @escaping () -> Void) {
        print("API: No API Selected")
        completed()
    }
    
    public func getHistory(completed: @escaping (_DataTracks_) -> Void) {
        print("API: No API Selected")
        completed(_DataTracks_(platform: .None))
    }
    
    public func createPlaylist(title: String, completed: @escaping (String) -> Void) {
        print("API: No API Selected")
        completed("")
    }
    
    public func addTracksToPlaylist(playlist_id: String, tracks_id: [String], completed: @escaping (Bool) -> Void) {
        print("API: No API Selected")
        completed(false)
    }
    
    public func addTrackToFavorite(track_id: String, completed: @escaping (Bool) -> Void) {
        print("API: No API Selected")
        completed(false)
    }
    
    public func SearchPlaylist(search: String, completed: @escaping (_DataPlaylists_) -> Void) {
        print("API: No API Selected")
        completed(_DataPlaylists_(platform: .None))
    }
    
    public func SearchTrack(search: String, completed: @escaping (_DataTracks_) -> Void) {
        print("API: No API Selected")
        completed(_DataTracks_(platform: .None))
    }
    
    public func SearchUser(search: String, completed: @escaping (_DataUsers_) -> Void) {
        print("API: No API Selected")
        completed(_DataUsers_(platform: .None))
    }
    
    public func getImageAlbum(tracks: _DataTracks_, index: Int, completed: @escaping () -> Void) {
        print("API: No API Selected")
        completed()
    }
}
