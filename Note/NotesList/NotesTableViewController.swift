//
//  NotesTableViewController.swift
//  Note
//
//  Created by ios_school on 3/2/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController {
    
    var notebook: [Note] = []
    var isEditable: Bool = true
       
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        tableView.isEditing = tableView.isEditing ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notebook.append(Note(title: "first", content: "note", color: UIColor.red, selfDestructDate: nil, importance: .usual))
        notebook.append(Note(title: "second", content: "note with huuuuge amount of words to show how this content property could expand properly even if its more than 5 lines and of course with ellipsis in the end", color: UIColor.yellow, selfDestructDate: nil, importance: .usual))
        notebook.append(Note(title: "third", content: "note", color: UIColor.green, selfDestructDate: nil, importance: .usual))
        notebook.append(Note(title: "fourth", content: "note", color: UIColor.yellow, selfDestructDate: nil, importance: .usual))
        notebook.append(Note(title: "fifth", content: "note", color: UIColor.red, selfDestructDate: nil, importance: .usual))
       }

}

extension NotesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteViewCell", for: indexPath) as! NotesTableViewCell
        let currentNote = notebook[indexPath.row]
        
        cell.title.text = currentNote.title
        cell.content.text = currentNote.content
        cell.content.numberOfLines = 5
        cell.colorSquare.backgroundColor = currentNote.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    }
    
}
