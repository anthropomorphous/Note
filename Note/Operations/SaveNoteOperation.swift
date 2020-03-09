import Foundation

class SaveNoteOperation: AsyncOperation {
    private let saveToBackend: SaveNotesBackendOperation
    private let saveToDb: SaveNoteDBOperation
    private let dbQueue: OperationQueue
    
    private(set) var result: Bool? = false
    
    init(note: Note,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {

        saveToBackend = SaveNotesBackendOperation(notes: notebook.notesArray)
        saveToDb = SaveNoteDBOperation(note: note, notebook: notebook)
        self.dbQueue = dbQueue

        super.init()

        saveToDb.completionBlock = {
            backendQueue.addOperation(self.saveToBackend)
        }
        dbQueue.addOperation(saveToDb)
        addDependency(saveToBackend)
        addDependency(saveToDb)
    }

    override func main() {
        if let result = saveToBackend.result {
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
