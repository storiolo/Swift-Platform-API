//  playlify
//
//  Created by Nicolas Storiolo on 22/10/2023.
//

import Foundation
import SwiftUI
import SpotifyWebAPI
import DeezerAPI


public class _user_: ObservableObject, Identifiable {
    public var id = UUID()
    
    @Published public var uri: String = ""
    @Published public var displayName: String = ""
    @Published public var image: Image? = nil
    @Published public var platform: platform = .None

    public init() {}
    
    public init(_ user: DeezerUser) {
        self.displayName = user.name ?? "N/A"
        self.uri = String(user.id ?? 0)
        self.platform = .Deezer
    }

    public init(_ user: SpotifyUser) {
        self.displayName = user.displayName ?? "N/A"
        self.uri = user.uri
        self.platform = .Spotify
    }
}
