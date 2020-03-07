import Foundation

enum RemoveNotesBackendResult {
    case success
    case failure(NetworkError)
}

class RemoveNotesBackendOperation: BaseBackendOperation {
    var result: RemoveNotesBackendResult?
    
    init(notes: [Note]) {
        super.init()
    }
    
    override func main() {
        result = .failure(.unreachable)
        finish()
    }
}

