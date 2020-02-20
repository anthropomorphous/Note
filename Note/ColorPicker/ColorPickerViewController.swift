import UIKit


class ColorPickerViewController: UIViewController {
    
    var currentColor: UIColor = UIColor.white

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var colorCode: UILabel!
    @IBOutlet weak var gradientView: ColorPickerView!
    @IBOutlet weak var pointer: PointerView!
    
    weak var delegate: NoteColorEdit?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(container)
        setup(gradientView)
        
        pointer.center = gradientView.getPointForColor(color: currentColor)
        preview.backgroundColor = currentColor
    }
    
    func update(_ location: CGPoint) {
        let x = min(max(0, location.x), gradientView.frame.width)
        let y = min(max(0, location.y), gradientView.frame.height)
        let rightLocation = CGPoint(x: x, y: y)
        currentColor = gradientView.getColorAtPoint(point: rightLocation)
        preview.backgroundColor = currentColor
        pointer.center = rightLocation
        pointer.fillColor = currentColor
        colorCode.text = currentColor.htmlRGBaColor
        delegate?.toColor(of: currentColor)
    }
    
    private func setup(_ field: UIView) {
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: gradientView)
        update(location)
    }
    
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: gradientView)
        update(location)
    }
    
}

