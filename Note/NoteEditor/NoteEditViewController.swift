import UIKit

protocol Colorable: AnyObject {
    func passValue(of color: UIColor)
  //  func passValue(of coordinates: CGPoint, and brightness: Float)
}

class NoteEditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
   
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var whiteFieldView: ColorSquare!
    @IBOutlet weak var redFieldView: ColorSquare!
    @IBOutlet weak var greenFieldView: ColorSquare!
    @IBOutlet weak var gradientFieldView: ColorSquare!
    
    @IBOutlet weak var dateSwitcher: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!
    
    var selectedField: ColorSquare!
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func dateSwitch(_ sender: UISwitch) {
        if sender.isOn {
            datePicker.isHidden = false
            datePickerHeight.constant = 216
        }
        else {
            datePickerHeight.constant = 0
            datePicker.isHidden = true
        }
    }
    
    @IBAction func colorRectWhiteTapped(_ sender: UITapGestureRecognizer) {
        setColor(whiteFieldView)
    }
    @IBAction func colorRectRedTapped(_ sender: UITapGestureRecognizer) {
        setColor(redFieldView)
    }
    @IBAction func colorRectGreenTapped(_ sender: UITapGestureRecognizer) {
        setColor(greenFieldView)
    }
    
    @IBAction func gradientTapGestureRecognizer( _ sender: Any) {
//      if !gradientFieldView.isColorPallete {
//             guard let color = gradientFieldView.backgroundColor else { return }
//             setColor(gradientFieldView)
//         }
     }
    
    
    @IBAction func gradientFieldLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            performSegue(withIdentifier: "OpenColorPicker", sender: nil)
        }
    }
    
    private func setColor(_ view: ColorSquare?) {
        guard let view = view else {
            return
        }
        
        selectedField.isSelected = false
        selectedField.setNeedsDisplay()
        
        view.isSelected = true
        view.setNeedsDisplay()
        
        selectedField = view
    }
    
    private func setup(_ field: UIView) {
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedField = whiteFieldView
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.endEditing(true)
        return false
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}


extension NoteEditViewController: Colorable {
    
    func passValue(of color: UIColor) {
        if selectedField != gradientFieldView {
            selectedField.isSelected = false
            selectedField.setNeedsDisplay()
        }
        selectedField = gradientFieldView
        selectedField.isColorPallete = false
        selectedField.backgroundColor = color
    }
    
//    func passValue(of coordinates: CGPoint, and brightness: Float) {
//        cursorPosition = coordinates
//        brightnessValue = brightness
//    }
}
