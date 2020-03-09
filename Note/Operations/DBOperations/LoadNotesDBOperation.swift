import Foundation

class LoadNotesDBOperation: BaseDBOperation {
    private let note: Note
    private(set) var result: [Note]?
    
    init(note: Note,
         notebook: FileNotebook) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.loadFromFile()
        result = notebook.notesArray
        finish()
    }
}
