import UIKit

class NoteEditViewController: UIViewController {
    
    @IBOutlet weak var whiteFieldView: UIView!
    @IBOutlet weak var redFieldView: UIView!
    @IBOutlet weak var greenFieldView: UIView!
    @IBOutlet weak var gradientFieldView: UIImageView!
    

    @IBAction func gradientTapGestureRecognizer( _ sender: Any) {
         gradientFieldView.isUserInteractionEnabled = true
         let colorPickerViewController = ColorPickerViewController()
         present(colorPickerViewController, animated: true, completion: nil)
     }
    
    
    @IBAction func gradientFieldLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            performSegue(withIdentifier: "OpenColorPicker", sender: nil)
        }
    }
    
    
    func setup(fieldName: UIView) {
        fieldName.layer.borderWidth = 1
        fieldName.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(fieldName: whiteFieldView)
        setup(fieldName: redFieldView)
        setup(fieldName: greenFieldView)
        setup(fieldName: gradientFieldView)
        
    }
    


}
