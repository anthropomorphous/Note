import Foundation

class LoadNoteOperation: AsyncOperation {
    private let loadFromBackend: LoadNotesBackendOperation
    private let loadFromDb: LoadNotesDBOperation
    private let dbQueue: OperationQueue
    
    private(set) var result: Bool? = false
    
    init(note: Note,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {

        loadFromBackend = LoadNotesBackendOperation()
        loadFromDb = LoadNotesDBOperation(note: note, notebook: notebook)
        self.dbQueue = dbQueue

        super.init()

        loadFromBackend.completionBlock = {
            if let result = self.loadFromBackend.result {
                switch result {
                case .success(let notes):
                    let updateNotes = BlockOperation {
                        notebook.update(notes)
                    }
                    self.addDependency(updateNotes)
                    dbQueue.addOperation(updateNotes)
                    self.removeDependency(self.loadFromDb)
                case .failure:
                    dbQueue.addOperation(self.loadFromDb)
                }
            }
            self.finish()
        }
        addDependency(loadFromBackend)
        addDependency(loadFromDb)
        dbQueue.addOperation(loadFromDb)
    }

    override func main() {
        if let result = loadFromBackend.result {
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
