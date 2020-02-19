import UIKit

protocol NoteColorEdit: AnyObject {
    func toColor(of color: UIColor)
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
        setFlag(whiteFieldView)
    }
    @IBAction func colorRectRedTapped(_ sender: UITapGestureRecognizer) {
        setFlag(redFieldView)
    }
    @IBAction func colorRectGreenTapped(_ sender: UITapGestureRecognizer) {
        setFlag(greenFieldView)
    }
    
    @IBAction func gradientTapGestureRecognizer( _ sender: Any) {
      if !gradientFieldView.isColorPallete {
             setFlag(gradientFieldView)
         }
     }
    
    @IBAction func gradientFieldLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let storyboard = UIStoryboard(name: "ColorPicker", bundle: nil)

            guard let viewController = storyboard.instantiateInitialViewController()
                as? ColorPickerViewController else { return }
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.delegate = self
            setFlag(gradientFieldView)
            if !gradientFieldView!.isColorPallete {
                viewController.isPainted = true
            }
            present(viewController, animated: true)
        }
    }
    
    private func setFlag(_ view: ColorSquare?) {
        selectedField.isSelected = false
        selectedField.setNeedsDisplay()
        
        if let selectedView = view {
            selectedView.isSelected = true
            selectedView.setNeedsDisplay()
            selectedField = selectedView
        }
    }
    
    private func setup(_ field: UIView) {
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedField = whiteFieldView
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardSize.cgRectValue
        let keyboardViewEndFrame = self.view.convert(keyboardScreenEndFrame, from: self.view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardViewEndFrame.height,
                right: 0
            )
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    @objc func keyboardWillHide(_ notification:Notification) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension NoteEditViewController: NoteColorEdit {
    
    func toColor(of color: UIColor) {
        if selectedField != gradientFieldView {
            selectedField.isSelected = false
            selectedField.setNeedsDisplay()
        }
        selectedField = gradientFieldView
        selectedField.isColorPallete = false
        selectedField.backgroundColor = color
    }
}
