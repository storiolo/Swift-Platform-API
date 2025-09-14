//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI

public struct _user_: Identifiable {
    public var id = UUID()
    
    public var uri: String
    public var displayName: String
    public var image: Image?
    public var platform: platform
    
    public init(){
        self.displayName = ""
        self.uri = ""
        self.platform = .None
    }
    
    public init(_ user: DeezerUser){
        self.displayName = user.name ?? "N/A"
        self.uri = String(user.id ?? 0)
        self.platform = .Deezer
    }
    public init(_ user: SpotifyUser){
        self.displayName = user.displayName ?? "N/A"
        self.uri = user.uri
        self.platform = .Spotify
    }
}
