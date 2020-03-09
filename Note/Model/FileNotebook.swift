import UIKit.UIColor
import CocoaLumberjack


class FileNotebook {
    
    enum FileNotebookError: String, Error {
        case existingUid
    }
    
    let fileManager = FileManager.default
    static let fileName = "Notes.json"
    static let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
    private(set) var notes = [String: Note]()
    
    private(set) var notesArray = [Note]()
       
    func updateArr() {
        notesArray = notes.map({$0.value}).sorted(by: {$0.index > $1.index})
    }
    
    public func add(_ note: Note) {
//        guard notes[note.uid] != nil else {
//            notes[note.uid] = note
//            updateArr()
//            DDLogInfo("Note with id \(note.uid) is added.")
//            return
//        }
//        DDLogError("Note with id \(note.uid) could not be added, note with this uuid already exists")
        notes[note.uid] = note
        updateArr()
      //  throw FileNotebookError.existingUid
    }
    
    public func remove(with uid: String) {
        notes.removeValue(forKey: uid)
        updateArr()
        DDLogInfo("Note with \(uid) was removed.")
    }
    
    public func update(_ notes: [Note]) {
        self.notes = notes.reduce(into: [String:Note]()) {$0[$1.uid] = $1}
        saveToFile()
        updateArr()
    }
    
    public func saveToFile() {
        let notesArr = notes.map { $0.value.json }
        guard let usePath = FileNotebook.path else {
            DDLogError("Error in file path initializing.")
            return
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: notesArr, options: [])
            let strPath = usePath.appendingPathComponent(FileNotebook.fileName)
            fileManager.createFile(atPath: strPath.path, contents: jsonData)
        } catch {
            DDLogError("Error: \(error.localizedDescription).")
        }
        DDLogInfo("Notes are saved to file.")
    }
    
    public func loadFromFile() {
        guard let usePath = FileNotebook.path else {
            DDLogError("Error in file path initializing.")
            return
        }
        do {
            let strPath = usePath.appendingPathComponent(FileNotebook.fileName)
            if let data = fileManager.contents(atPath: strPath.path) {
                if let jsonNotes = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for note in jsonNotes {
                        if let note = Note.parse(json: note){
                            self.add(note)
                        }
                    }
                } else {
                    assertionFailure("There was an issue parsing the JSON")
                }
            }
            updateArr()
        } catch {
            DDLogError("Error: \(error.localizedDescription).")
        }
        DDLogInfo("Notes are loaded from file.")
    }

}
