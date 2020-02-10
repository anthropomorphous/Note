import UIKit

class GradientViewController: UIViewController {
    
    @IBOutlet weak var gradientView: ColorPickerView!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var colorCode: UILabel!
    @IBOutlet weak var brightSlider: UISlider!
    
    @IBAction func close(_ sender: UIButton) {
          dismiss(animated: true, completion: nil)
    }
    
    var gradientLayer: CAGradientLayer!
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
