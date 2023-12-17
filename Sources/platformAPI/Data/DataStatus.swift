//
//
//  Created by Nicolas Storiolo on 15/12/2023.
//

import Foundation

public class _arrStatus_: ObservableObject {
    @Published public var status: [_Status_] = []
    
    public init() {
        self.status = []
    }
    
    public struct _Status_: Identifiable, Hashable {
        public var id = UUID()
        public var isLoading: Bool = false
        public var text: String = ""
        public var ld_count: Int = 0
        public var ld_max: Int = 0
        
        init(text: String, ld_max: Int) {
            self.text = text
            self.ld_max = ld_max
        }
    }
    
    public func add_status(text: String, ld_max: Int) -> UUID {
        status.append(_Status_(text: text, ld_max: ld_max))
        let id = status[status.count-1].id
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let ind = self.find_status(id: id) {
                self.status[ind].isLoading = true
            }
        }
        return id
    }
    
    public func find_status(id: UUID) -> Int? {
        for (it, statu) in status.enumerated() {
            if statu.id == id {
                return it
            }
        }
        return nil
    }
        
    public func delete_status(id: UUID) {
        for (it, statu) in status.enumerated() {
            if statu.id == id {
                status[it].isLoading = false
                status[it].ld_count = status[it].ld_max
                status[it].text = "Success"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let ind = self.find_status(id: id) {
                        self.status.remove(at: ind)
                    }
                }
                break
            }
        }
    }
        
    public func inc_status(id: UUID) {
        for (it, statu) in status.enumerated() {
            if statu.id == id {
                status[it].ld_count += 1
                break
            }
        }
    }
    
    public func set_max(id: UUID, ld_max: Int) {
        for (it, statu) in status.enumerated() {
            if statu.id == id {
                status[it].ld_max = ld_max
                break
            }
        }
    }
    
    public func set_count(id: UUID, ld_count: Int) {
        for (it, statu) in status.enumerated() {
            if statu.id == id {
                status[it].ld_count = ld_count
                break
            }
        }
    }
}
