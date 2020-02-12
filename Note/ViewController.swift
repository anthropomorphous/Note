//
//  ViewController.swift
//  Note
//
//  Created by ios_school on 1/22/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func noteEdit(_ sender: UIButton) {
        let noteEditViewController = NoteEditViewController()
        present(noteEditViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }

}

