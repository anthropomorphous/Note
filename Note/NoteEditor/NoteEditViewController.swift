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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        whiteFieldView.layer.borderWidth = 1
//        whiteFieldView.layer.borderColor = UIColor.black.cgColor
        
       //setup(fieldView: whiteFieldView)
       // setup(fieldView: redFieldView)
       // setup(fieldView: greenFieldView)
       //setup(fieldView: gradientFieldView)

    }
    


}
