//  playlify
//
//  Created by Nicolas Storiolo on 24/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

public class _DeezerAPI_: ObservableObject, API {

    public var deezer: DeezerAPI
    public func getPlatform() -> platform {
        return .Deezer
    }
    
    public func AutoConnect() -> some View {
        return DeezerAPI.AutoConnect(deezer: deezer)
    }
    public func ConnectView(isShowingView: Binding<Bool>) -> some View {
        return DeezerAPI.ConnectView(deezer: deezer, isShowingView: isShowingView)
    }
    public func isConnected() -> Bool {
        return deezer.isConnected()
    }
    public func isDisconnected() -> Bool {
        return deezer.isDisconnected()
    }
    public func isTryingtoConnect() -> Bool {
        return deezer.isTryingtoConnect()
    }
    public func disconnect(){
        deezer.disconnect()
    }
    
    public init(clientId: String, clientSecret: String, redirect_uri: String, permissions: String) {
        self.deezer = DeezerAPI(clientId: clientId,
                                clientSecret: clientSecret,
                                redirect_uri: redirect_uri,
                                permissions: permissions)
    }
    
    @Published var isLoading = false
    @Published var ld_max = 0
    @Published var ld_count = 0
    public func getfuncStatus() -> (Bool, Int, Int){
        return (isLoading, ld_max, ld_count)
    }
    
}
