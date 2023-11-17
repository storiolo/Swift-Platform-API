//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI

public class _DataUsers_: ObservableObject {
    public var platform: platform
    @Published public var users: [_user_] = []
    
    public struct _user_: Identifiable {
        public var id = UUID()
        
        public var uri: String
        public var displayName: String
        public var image: Image?
        
        public init(platform: platform){
            self.displayName = "N/A"
            self.uri = ""
        }
        
        public init(_ user: DeezerUser){
            self.displayName = user.name ?? "N/A"
            self.uri = String(user.id ?? 0)
        }
        public init(_ user: SpotifyUser){
            self.displayName = user.displayName ?? "N/A"
            self.uri = user.uri
        }
    }
    
    public init(platform: platform) {
        self.platform = platform
    }
    
    
    //<<---- OPERATORS ---->>\\
    public static func ==(left: _DataUsers_, right: _DataUsers_) -> Bool {
        guard left.users.count == right.users.count else {
            return false
        }
        for (leftUser, rightUser) in zip(left.users, right.users) {
            if leftUser.uri != rightUser.uri {
                return false
            }
        }
        return true
    }
    public static func +=(left: inout _DataUsers_, right: _DataUsers_) {
        left.users += right.users
    }
    public static func +(left: _DataUsers_, right: _DataUsers_) -> _DataUsers_ {
        let out = left
        out.users += right.users
        return out
    }
    public func append(_ user: SpotifyUser) {
        self.users.append(_user_(user))
    }
    public func append(_ user: DeezerUser) {
        self.users.append(_user_(user))
    }
    public func copy(_ right: _DataUsers_) {
        self.users = right.users
        self.platform = right.platform
    }
    public func isIn(_ user: _user_) -> Bool {
        for item in self.users {
            if item.uri == user.uri {
                return true
            }
        }
        return false
    }
    
}
