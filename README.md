# platform API
A Swift library for the Spotify and Deezer API

## Supported Platforms

* Swift 5.3+
* iOS 13+
* macOS 10.15+
* tvOS 13+
* watchOS 6+
* Linux

## Installation

1. In Xcode, open the project that you want to add this package to.
2. From the menu bar, select File > Swift Packages > Add Package Dependency...
3. Paste the url for this repository into the search field.
5. Select the `platform API` Library.
4. Follow the prompts for adding the package.

## Quick Start

Below is an example of how you can use the library:
```swift
import Foundation
import platformAPI
//import SpotifyWebAPI
//import DeezerAPI

class environmentData: ObservableObject {
    @Published var spotify = _SpotifyAPI_(clientId: S_CLIENTID,
                                          clientSecret: S_CLIENTSECRET,
                                          redirect_uri: S_REDIRECTURI,
                                          permissions: [??? (eg: .userReadPlaybackState)],
                                          service: "com.???.???")
    @Published var deezer = _DeezerAPI_(clientId: D_CLIENTID,
                                        clientSecret: D_CLIENTSECRET,
                                        redirect_uri: D_REDIRECTURI,
                                        permissions: "???")
    
    @Published var api: API = _NoAPI_()

    init() {
        self.changePlatform(platform: .None)
    }
    
    
    func changePlatform(platform: platform){
        self.database.platform = platform
        switch platform {
        case .Spotify:
            self.api = self.spotify
        case .Deezer:
            self.api = self.deezer
        case .None:
            self.api = _NoAPI_()
        }
    }
}


//Now call api to execute request
    @EnvironmentObject var envData: environmentData
    envData.api.YOURREQUEST()
```

Note: All request are listed in the API file

Recommandation :
    - [Deezer API][1]
    - [Spotify API][2]

[1]: https://github.com/storiolo/Swift-Deezer-API
[2]: https://github.com/Peter-Schorn/SpotifyAPI
