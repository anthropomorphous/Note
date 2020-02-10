import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var whiteFieldView: UIView!
    @IBOutlet weak var redFieldView: UIView!
    @IBOutlet weak var greenFieldView: UIView!
    @IBOutlet weak var gradientFieldView: UIImageView!
    
    @IBAction func gradientTapGestureRecognizer( _ sender: Any) {
        gradientFieldView.isUserInteractionEnabled = true
        let gradientViewController = GradientViewController()
        present(gradientViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(fieldView: whiteFieldView)
        setup(fieldView: redFieldView)
        setup(fieldView: greenFieldView)
        setup(fieldView: gradientFieldView)

    }
    
    @IBAction func showGradientViewController(_ vc: UIViewController, sender: Any?) {
        let gradientViewController = GradientViewController()
        present(gradientViewController, animated: true, completion: nil)
    }
    
    func setup(fieldView: UIView) {
        fieldView.layer.borderWidth = 1
        fieldView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
