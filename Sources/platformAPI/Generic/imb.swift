//
//  imb.swift
//  platformAPI
//
//  Created by Nicolas Storiolo on 27/09/2025.
//

protocol HasPlatform {
    var platform: platform { get }
}

extension _user_: HasPlatform {}
extension _playlist_: HasPlatform {}
extension _track_: HasPlatform {}


func _imb_<Input, Output: HasPlatform>(
    items: [Input],
    fetch: @escaping (Input, @escaping (Output) -> Void) -> Void,
    completed: @escaping ([Output]) -> Void
) {
    var out: [Output] = []

    func openNext(index: Int) {
        guard index < items.count else {
            completed(out)
            return
        }

        fetch(items[index]) { result in
            //no platform = no result
            if result.platform != platform.None {
                out.append(result)
            }
            openNext(index: index + 1)

        }
    }

    openNext(index: 0)
}
