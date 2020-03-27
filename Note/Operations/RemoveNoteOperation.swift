import Foundation

class RemoveNoteOperation: AsyncOperation {
    private let removeFromDb: RemoveNoteDBOperation
    private let saveToBackend: SaveNotesBackendOperation
    private let dbQueue: OperationQueue
    
    private(set) var result: Bool? = false
    
    init(uid: String,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {

        saveToBackend = SaveNotesBackendOperation(notes: notebook.notesArray)
        removeFromDb = RemoveNoteDBOperation(uid: uid, notebook: notebook)
        self.dbQueue = dbQueue

        super.init()

        removeFromDb.completionBlock = {
            backendQueue.addOperation(self.saveToBackend)
        }
        self.addDependency(saveToBackend)
        self.addDependency(removeFromDb)
        dbQueue.addOperation(removeFromDb)
    }

    override func main() {
        if let result = self.saveToBackend.result {
            switch result {
            case .success:
                self.result = true
            case .failure:
                self.result = false
            }
        }
        self.finish()
    }
}
