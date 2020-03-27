import Foundation

class LoadNotesDBOperation: BaseDBOperation {
    private(set) var result: [Note]?
    
    override init(notebook: FileNotebook) {
        super.init(notebook: notebook)
    }
    
    override func main() {
    //    notebook.loadFromFile()
        result = notebook.notesArray
        finish()
    }
}
