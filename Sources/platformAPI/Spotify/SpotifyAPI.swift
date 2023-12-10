//  playlify
//
//  Created by Nicolas Storiolo on 17/08/2023.
//

import Foundation
import Combine
import KeychainAccess
import SpotifyWebAPI


public class _SpotifyAPI_: ObservableObject, API {
    public func getPlatform() -> platform {
        return .Spotify
    }
    
    @Published var isAuthorized = false
    @Published var isRetrievingTokens = false
    
    var api: SpotifyAPI<AuthorizationCodeFlowManager>
    let authorizationManagerKey = "authorizationManager"
    var authorizationState = String.randomURLSafe(length: 128)
    public var cancellables: Set<AnyCancellable> = []
    
    var loginCallbackURL: URL
    var scopes: Set<Scope>
    var keychain: Keychain

    
    public init(clientId: String, clientSecret: String, redirect_uri: String, permissions: Set<Scope>, service: String){
        api = SpotifyAPI(authorizationManager: AuthorizationCodeFlowManager(clientId: clientId, clientSecret: clientSecret))
        loginCallbackURL = URL(string: redirect_uri)!
        scopes = permissions
        keychain = Keychain(service: service)
        
        //self.api.apiRequestLogger.logLevel = .trace
        self.api.authorizationManagerDidChange
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidChange)
            .store(in: &cancellables)
        self.api.authorizationManagerDidDeauthorize
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidDeauthorize)
            .store(in: &cancellables)
        
        // MARK: Check to see if the authorization information is saved in the keychain.
        if let authManagerData = keychain[data: self.authorizationManagerKey] {
            do {
                let authorizationManager = try JSONDecoder().decode(AuthorizationCodeFlowManager.self, from: authManagerData)
                print("Spotify: Found Keychain")
                self.api.authorizationManager = authorizationManager
            } catch {
                print("could not decode authorizationManager from data:\n\(error)")
            }
        }
        else {
            print("did NOT find authorization information in keychain")
        }
    }
    
    public func isConnected() -> Bool {
        return self.isAuthorized
    }
    public func isDisconnected() -> Bool {
        return !self.isAuthorized
    }
    public func isTryingtoConnect() -> Bool {
        return false
    }
    public func disconnect(){
        authorizationManagerDidDeauthorize()
    }
    

    @Published var arrStatus = _arrStatus_()
    public func getfuncStatus() -> [_arrStatus_._Status_] {
        return arrStatus.status
    }
    
}
