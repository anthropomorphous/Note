import UIKit


protocol ColorPickerDelegate : class {
    func colorPickerColorSelected(color: UIColor)
}

final class ColorPickerViewController: UIViewController {

    @IBOutlet weak var colorPickerMainView: ColorPickerMainView!
    
    var currentColor = UIColor.white
    weak var delegate: ColorPickerDelegate?
       
    override func viewDidLoad() {
        super.viewDidLoad()
           
        colorPickerMainView.defaultColor = currentColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
    }
       
    @objc func save() {
        delegate?.colorPickerColorSelected(color: colorPickerMainView.defaultColor)
        navigationController?.popViewController(animated: true)
    }
}

