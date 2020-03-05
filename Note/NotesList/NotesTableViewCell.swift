//
//  NotesTableViewCell.swift
//  Note
//
//  Created by ios_school on 3/2/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var colorSquare: UIView!
    
    var color = UIColor.white {
        didSet {
            colorSquare.backgroundColor = color
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            colorSquare.backgroundColor = color
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            colorSquare.backgroundColor = color
        }
    }
    
}