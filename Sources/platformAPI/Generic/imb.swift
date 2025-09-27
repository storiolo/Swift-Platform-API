//
//  imb.swift
//  platformAPI
//
//  Created by Nicolas Storiolo on 27/09/2025.
//

public func _imb_<Input, Output>(
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
            out.append(result)
            openNext(index: index + 1)
        }
    }

    openNext(index: 0)
}
