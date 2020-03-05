//
//  NotesTableViewController.swift
//  Note
//
//  Created by ios_school on 3/2/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController {
    
    var isEditable: Bool = true
    let fileNotebook = FileNotebook()
       
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let noteEditVC = segue.destination as? NoteEditViewController,
            segue.identifier == "EditNote" {
            var note: Note
            if let index = sender as? Int {
                note = fileNotebook.notesArray[index]
            } else {
                note = Note(title: "", content: "", selfDestructDate: nil, importance: .usual)
            }
            noteEditVC.receivedNote = note
            noteEditVC.fileNotebook = fileNotebook
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        tableView.isEditing = tableView.isEditing ? false : true
    }
    
    func noteTapped(at index: Int) {
        performSegue(withIdentifier: "EditNote", sender: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileNotebook.add(Note(title: "first", content: "note", color: UIColor.red, selfDestructDate: nil, importance: .usual))
        fileNotebook.add(Note(title: "second", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pharetra, nunc sit amet placerat tincidunt, mauris mi consequat purus, nec ultricies felis erat vel velit. Fusce sed nunc sit amet ante rutrum euismod at quis libero. Maecenas accumsan lobortis neque sed mollis. Nam vitae consequat sem. Duis vitae sem in dui ultricies viverra lobortis vel purus.", color: UIColor.yellow, selfDestructDate: nil, importance: .usual))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
   
}

extension NotesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileNotebook.notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteViewCell", for: indexPath) as! NotesTableViewCell
        let currentNote = fileNotebook.notesArray[indexPath.row]
        
        cell.title.text = currentNote.title
        cell.content.text = currentNote.content
        cell.colorSquare.backgroundColor = currentNote.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteTapped(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.fileNotebook.remove(with: self.fileNotebook.notesArray[indexPath.row].uid)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        tableView.reloadData()
    }
    
}
