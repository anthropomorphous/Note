import UIKit

final class NoteEditViewController: UIViewController, UITextFieldDelegate {
    
    private var flag = ColorFlagView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var chosenColor = UIColor.white
    

    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var whiteFieldView: ColorSquare!
    @IBOutlet weak var redFieldView: ColorSquare!
    @IBOutlet weak var greenFieldView: ColorSquare!
    @IBOutlet weak var gradientFieldView: GradientSquare!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!
    
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
        chosenColor = UIColor.white
    }
    @IBAction func colorRectRedTapped(_ sender: UITapGestureRecognizer) {
        chosenColor = UIColor.red
    }
    @IBAction func colorRectGreenTapped(_ sender: UITapGestureRecognizer) {
        chosenColor = UIColor.green
    }
    
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
    
    
    func setup(_ fieldName: UIView) {
        fieldName.layer.borderWidth = 1
        fieldName.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        titleField.delegate = self
//        textViewDidChange(contentField)
        
        setup(whiteFieldView)
        setup(redFieldView)
        setup(greenFieldView)
        setup(gradientFieldView)
        
        flagTo(chosenColor)
        
        NotificationCenter.default.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func flagTo(_ color: UIColor) {
        switch color {
        case UIColor.white:
            whiteFieldView.addSubview(flag)
        case UIColor.red:
            redFieldView.addSubview(flag)
        case UIColor.green:
            greenFieldView.addSubview(flag)
        default:
            gradientFieldView.addSubview(flag)
            gradientFieldView.backgroundColor = color
           // gradientFieldView.isColorPallete = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
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
