//  playlify
//
//  Created by Nicolas Storiolo on 30/10/2023.
//

import Foundation
import SwiftUI
import DeezerAPI

extension _DeezerAPI_ {
    public func Play(){
        print("Not Available on Deezer")
    }
    public func Pause(){
        print("Not Available on Deezer")
    }
    public func Next(){
        print("Not Available on Deezer")
    }
    public func Previous(){
        print("Not Available on Deezer")
    }
    public func UserQueue(completed: @escaping ([_track_]) -> Void){
        print("Not Available on Deezer")
        completed([_track_]())
    }
    public func AddToUserQueue(track_id: String){
        print("Not Available on Deezer")
    }
    public func Play(tracks_id: [String]){
        print("Not Available on Deezer")
    }
    public func Play(track_id: String){
        print("Not Available on Deezer")
    }
}
