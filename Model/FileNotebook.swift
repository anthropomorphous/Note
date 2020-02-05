import UIKit

class FileNotebook {
    
    enum FileNotebookError: String, Error {
        case existingUid
    }
    
    let fileManager = FileManager.default
    static let fileName = "Notes.json"
    static let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
    private(set) var notes = [String: Note]()
    
    public func add(_ note: Note) throws {
        guard notes[note.uid] != nil else {
            notes[note.uid] = note
            return
        }
        throw FileNotebookError.existingUid
        
    }
    
    public func remove(with uid: String) {
        notes.removeValue(forKey: uid)
    }
    
    public func saveToFile() {
        let notesArr = notes.map { $0.value.json }
        guard let usePath = FileNotebook.path else {
            NSLog("Error")
            return
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: notesArr, options: [])
            let strPath = usePath.appendingPathComponent(FileNotebook.fileName)
            fileManager.createFile(atPath: strPath.path, contents: jsonData)
        } catch {
            NSLog("Error")
        }
    }
    
    public func loadFromFile() {
        guard let usePath = FileNotebook.path else {
            NSLog("Error")
            return
        }
        do {
            let strPath = usePath.appendingPathComponent(FileNotebook.fileName)
            if let data = fileManager.contents(atPath: strPath.path) {
                if let jsonNotes = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for note in jsonNotes {
                        if let note = Note.parse(json: note){
                            try self.add(note)
                        }
                    }
                } else {
                    assertionFailure("There was an issue parsing the JSON")
                }
            }
        } catch {
            NSLog("Error")
        }
            
    }

}
