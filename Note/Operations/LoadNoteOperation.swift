import Foundation

class LoadNoteOperation: AsyncOperation {
    private let loadFromDb: LoadNoteDBOperation
    private let dbQueue: OperationQueue
    
    private(set) var result: Bool? = false
    
    init(note: Note,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {

        loadFromDb = LoadNoteDBOperation(note: note, notebook: notebook)
        self.dbQueue = dbQueue

        super.init()

        loadFromDb.completionBlock = {
            let loadFromBackend = LoadNotesBackendOperation(notes: notebook.notesArray)
            loadFromBackend.completionBlock = {
                switch loadFromBackend.result! {
                case .success:
                    self.result = true
                case .failure:
                    self.result = false
                }
                self.finish()
            }
            backendQueue.addOperation(loadFromBackend)
        }
    }

    override func main() {
        dbQueue.addOperation(loadFromDb)
    }
}
