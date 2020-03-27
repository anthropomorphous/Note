import Foundation

class LoadNotesOperation: AsyncOperation {
    private let loadFromBackend: LoadNotesBackendOperation
    private let loadFromDb: LoadNotesDBOperation
    private let dbQueue: OperationQueue
    
    private(set) var result: FileNotebook?
    
    init(notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {

        loadFromBackend = LoadNotesBackendOperation()
        loadFromDb = LoadNotesDBOperation(notebook: notebook)
        self.dbQueue = dbQueue

        super.init()
        
        func updateNotebook(with notes: [Note]) {
            notebook.removeAll()
            for note in notes {
                notebook.add(note)
            }
            self.result = notebook
        }
        
        loadFromBackend.completionBlock = {
            switch self.loadFromBackend.result {
            case .success(let notes):
                updateNotebook(with: notes)
                
            case .failure:
                let loadFromDB = LoadNotesDBOperation(notebook: notebook)

                loadFromDB.completionBlock = {
                    guard let notes = loadFromDB.result else { return }
                    updateNotebook(with: notes)
                }

                dbQueue.addOperation(loadFromDB)
            case .none:
                return
            }
            self.finish()
        }
    //    addDependency(loadFromBackend)
    //    addDependency(loadFromDb)
   }

    override func main() {
        dbQueue.addOperation(loadFromBackend)
    }
}
