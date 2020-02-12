import UIKit

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var colorContainer: UIView!
    @IBOutlet weak var colorCode: UILabel!
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var gradientView: ColorPickerView!
    
    @IBAction func close(_ sender: UIButton) {
          dismiss(animated: true, completion: nil)
    }
    
    @IBAction func brightnessChanged(_ sender: UISlider) {
//           gradientView.brightness = CGFloat(sender.value)
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorContainer.layer.borderWidth = 1
        colorContainer.layer.borderColor = UIColor.black.cgColor
    }
    
    

}
