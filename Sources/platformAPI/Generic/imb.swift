//
//  imb.swift
//  platformAPI
//
//  Created by Nicolas Storiolo on 27/09/2025.
//

public func _imb_<T>(
    items: [T],
    fetch: @escaping (T, @escaping (T) -> Void) -> Void,
    completed: @escaping ([T]) -> Void
) {
    var out: [T] = []

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
