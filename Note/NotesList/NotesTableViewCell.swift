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
}
