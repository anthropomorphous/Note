import UIKit


class ColorPickerViewController: UIViewController {

    @IBOutlet weak var colorPickerMainView: ColorPickerMainView!
    
    var currentColor = UIColor.white
    weak var delegate: Colorable?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerMainView.setNeedsDisplay()
        delegate?.passValue(of: colorPickerMainView.currentColor)
           
    }

}

