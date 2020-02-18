import UIKit

protocol ColorPickerDelegate: class {
    func colorPickerColorSelected(color: UIColor)
}

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var colorPickerMainView: ColorPickerMainView!
    
    var currentColor = UIColor.white
    weak var delegate: ColorPickerDelegate?
       
    override func viewDidLoad() {
        super.viewDidLoad()
           
        colorPickerMainView.currentColor = currentColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
    }
    
    @objc func save() {
        delegate?.colorPickerColorSelected(color: colorPickerMainView.currentColor)
        navigationController?.popViewController(animated: true)
    }
}

