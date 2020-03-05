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
    
    var titleText: String?
    var contentText: String?
    var color: UIColor?
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        title.text = titleText
//        content.text = contentText
//        colorSquare.backgroundColor = color
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
