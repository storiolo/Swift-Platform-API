import Foundation
import Combine
import SwiftUI
//import KeychainAccess
import SpotifyWebAPI



extension _SpotifyAPI_ {
    //Method that creates the authorization URL and opens it in the browser.
    public func ConnectView() {
        let url = self.api.authorizationManager.makeAuthorizationURL(
            redirectURI: self.loginCallbackURL,
            showDialog: true,
            state: self.authorizationState,
            scopes: self.scopes
        )!
        #if os(iOS) || os(watchOS) || os(tvOS)
            UIApplication.shared.open(url)
        #elseif os(macOS)
            NSWorkspace.shared.open(url)
        #endif
    }
    
    /**
     Saves changes to `api.authorizationManager` to the keychain.
     
     This method is called every time the authorization information changes. For
     example, when the access token gets automatically refreshed, (it expires
     after an hour) this method will be called.
     
     It will also be called after the access and refresh tokens are retrieved
     using `requestAccessAndRefreshTokens(redirectURIWithQuery:state:)`.
     */
    func authorizationManagerDidChange() {
        self.isAuthorized = self.api.authorizationManager.isAuthorized()
        print("Spotify: isAuthorized", self.isAuthorized)
        
        do {
            let authManagerData = try JSONEncoder().encode(self.api.authorizationManager)
            self.keychain[data: self.authorizationManagerKey] = authManagerData
        } catch {
            print("couldn't encode authorizationManager for storage " + "in keychain:\n\(error)")
        }
        
    }
    
    /**
     Removes `api.authorizationManager` from the keychain and sets `currentUser`
     to `nil`.
     
     This method is called every time `api.authorizationManager.deauthorize` is
     called.
     */
    func authorizationManagerDidDeauthorize() {
        self.isAuthorized = false
        do {
            try self.keychain.remove(self.authorizationManagerKey)
            print("did remove authorization manager from keychain")
            
        } catch {
            print("couldn't remove authorization manager " + "from keychain: \(error)")
        }
    }
    
    
    
    /**
     Handle the URL that Spotify redirects to after the user Either authorizes
     or denies authorization for the application.
     
     This method is called by the `onOpenURL(perform:)` view modifier directly
     above.
     */
    public func handleURL(_ url: URL) {
        
        // **Always** validate URLs; they offer a potential attack vector into
        // your app.
        guard url.scheme == self.loginCallbackURL.scheme else {
            print("not handling URL: unexpected scheme: '\(url)'")
            return
        }
        
        print("received redirect from Spotify: '\(url)'")
        
        // This property is used to display an activity indicator in `LoginView`
        // indicating that the access and refresh tokens are being retrieved.
        self.isRetrievingTokens = true
        
        // Complete the authorization process by requesting the access and
        // refresh tokens.
        self.api.authorizationManager.requestAccessAndRefreshTokens(
            redirectURIWithQuery: url,
            // This value must be the same as the one used to create the
            // authorization URL. Otherwise, an error will be thrown.
            state: self.authorizationState
        )
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            // Whether the request succeeded or not, we need to remove the
            // activity indicator.
            self.isRetrievingTokens = false
            
            /*
             After the access and refresh tokens are retrieved,
             `SpotifyAPI.authorizationManagerDidChange` will emit a signal,
             causing `Spotify.authorizationManagerDidChange()` to be called,
             which will dismiss the loginView if the app was successfully
             authorized by setting the @Published `Spotify.isAuthorized`
             property to `true`.
             
             The only thing we need to do here is handle the error and show it
             to the user if one was received.
             */
            if case .failure(let error) = completion {
                print("couldn't retrieve access and refresh tokens:\n\(error)")
            }
        })
        .store(in: &cancellables)
        
        // MARK: IMPORTANT: generate a new value for the state parameter after
        // MARK: each authorization request. This ensures an incoming redirect
        // MARK: from Spotify was the result of a request made by this app, and
        // MARK: and not an attacker.
        self.authorizationState = String.randomURLSafe(length: 128)
        
    }
    
}
