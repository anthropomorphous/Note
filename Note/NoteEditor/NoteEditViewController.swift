import UIKit
import CocoaLumberjack

class NoteEditViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var whiteFieldView: ColorSquare!
    @IBOutlet weak var redFieldView: ColorSquare!
    @IBOutlet weak var greenFieldView: ColorSquare!
    @IBOutlet weak var gradientFieldView: ColorSquare!
    
    @IBOutlet weak var dateSwitcher: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!
    
    var selectedField: ColorSquare!
    var receivedNote: Note?
    var currentColor: UIColor?
    var notebook: FileNotebook?
    
    var queue = OperationQueue()
    var dbQueue = OperationQueue()
    var backendQueue = OperationQueue()
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func dateSwitch(_ sender: UISwitch) {
        datePicker.isHidden = sender.isOn ? false : true
    }
    
    @IBAction func colorRectWhiteTapped(_ sender: UITapGestureRecognizer) {
        setFlag(to: whiteFieldView)
    }
    @IBAction func colorRectRedTapped(_ sender: UITapGestureRecognizer) {
        setFlag(to: redFieldView)
    }
    @IBAction func colorRectGreenTapped(_ sender: UITapGestureRecognizer) {
        setFlag(to: greenFieldView)
    }
    
    @IBAction func gradientTapGestureRecognizer(_ sender: Any) {
      if !gradientFieldView.isColorPallete {
        setFlag(to: gradientFieldView)
        }
     }
    
    @IBAction func gradientFieldLongPressed(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == UIGestureRecognizer.State.began else { return }
        let storyboard = UIStoryboard(name: "ColorPicker", bundle: nil)

        guard let viewController = storyboard.instantiateInitialViewController()
            as? ColorPickerViewController else { return }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.delegate = self
        setFlag(to: gradientFieldView)
        present(viewController, animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let destructionDate = dateSwitcher.isOn ? datePicker.date : nil
        guard let note = receivedNote else { return }
        
        let newNote = Note(index: note.index, uid: note.uid, title: titleField.text!, content: contentField.text, color: currentColor!, selfDestructDate: destructionDate, importance: note.importance)
     //   print(notebook!.notesArray.count)
     //   print(newNote.title)
        let saveNoteOperation = SaveNoteOperation(note: newNote, notebook: notebook ?? FileNotebook(), backendQueue: backendQueue, dbQueue: dbQueue)
        self.queue.addOperation(saveNoteOperation)
        self.queue.waitUntilAllOperationsAreFinished()
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setFlag(to view: ColorSquare?) {
        setViewSelected(selectedField, false)
        if let selectedView = view {
            setViewSelected(selectedView, true)
            selectedField = selectedView
            currentColor = selectedView.backgroundColor!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.endEditing(true)
        return false
    }
    
    private func setup(_ field: UIView) {
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setColor(to view: ColorSquare) {
        selectedField = view
        setFlag(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        
        if receivedNote == nil {
            selectedField = whiteFieldView
            setFlag(to: whiteFieldView)
        } else {
            currentColor = receivedNote?.color
            titleField.text = receivedNote?.title
            contentField.text = receivedNote?.content
            
            switch receivedNote?.color {
            case UIColor.white:
                setColor(to: whiteFieldView)
            case UIColor.green:
                setColor(to: greenFieldView)
            case UIColor.red:
                setColor(to: redFieldView)
            default:
                gradientFieldView.isColorPallete = false
                gradientFieldView.backgroundColor = receivedNote?.color
                setColor(to: gradientFieldView)
            }
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(NoteEditViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardSize.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

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
        scrollView.contentInset = UIEdgeInsets.zero
    }
}

extension NoteEditViewController: NoteColorEdit {
    
    func toColor(of color: UIColor) {
        if selectedField != gradientFieldView {
            setViewSelected(selectedField, false)
        }
        selectedField = gradientFieldView
        selectedField.isColorPallete = false
        selectedField.backgroundColor = color
        currentColor = color
    }
    
    func setViewSelected(_ view: ColorSquare, _ temp: Bool)
    {
        view.isSelected = temp
        view.setNeedsDisplay()
    }
}
