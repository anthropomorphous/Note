import UIKit

class NotesTableViewController: UIViewController {
    
    var isEditable: Bool = true
    var notebook = FileNotebook()
    var queue = OperationQueue()
    var dbQueue = OperationQueue()
    var backendQueue = OperationQueue()
       
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let noteEditViewController = segue.destination as? NoteEditViewController,
            segue.identifier == "EditNote" {
            var note: Note
            if let index = sender as? Int {
                note = notebook.notesArray[index]
            } else {
                note = Note(index: notebook.notesArray.count, title: "", content: "", selfDestructDate: nil, importance: .usual)
            }
            noteEditViewController.receivedNote = note
            noteEditViewController.notebook = notebook
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        tableView.beginUpdates()
        tableView.isEditing = tableView.isEditing ? false : true
        tableView.endUpdates()
    }
    
    func noteTapped(at index: Int) {
        performSegue(withIdentifier: "EditNote", sender: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notebook.add(Note(index: notebook.notesArray.count, title: "first", content: "note", color: UIColor.red, selfDestructDate: nil, importance: .usual))
        notebook.add(Note(index: notebook.notesArray.count, title: "second", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pharetra, nunc sit amet placerat tincidunt, mauris mi consequat purus, nec ultricies felis erat vel velit. Fusce sed nunc sit amet ante rutrum euismod at quis libero. Maecenas accumsan lobortis neque sed mollis. Nam vitae consequat sem. Duis vitae sem in dui ultricies viverra lobortis vel purus.", color: UIColor.yellow, selfDestructDate: nil, importance: .usual))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loadNoteOperation = LoadNotesOperation(notebook: self.notebook, backendQueue: self.backendQueue, dbQueue: self.dbQueue)
             self.queue.addOperation(loadNoteOperation)
             loadNoteOperation.completionBlock = {
                 if let newNotebook = loadNoteOperation.result {
                     self.notebook = newNotebook
                 }
             }
        tableView.reloadData()
    }
}

extension NotesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteViewCell", for: indexPath) as! NotesTableViewCell
        let currentNote = notebook.notesArray[indexPath.row]
        
        cell.title.text = currentNote.title
        cell.content.text = currentNote.content
        cell.colorSquare.backgroundColor = currentNote.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteTapped(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let uid = self.notebook.notesArray[indexPath.row].uid
            let removeNoteOperation = RemoveNoteOperation(uid: uid, notebook: self.notebook, backendQueue: self.backendQueue, dbQueue: self.dbQueue)
            self.queue.addOperation(removeNoteOperation)
            self.queue.waitUntilAllOperationsAreFinished()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
