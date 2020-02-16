import UIKit

@IBDesignable
final class ColorSquare: UIView {

    @IBInspectable var isColorPallete: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isColorPallete {
            ColorPickerView.drawPallete(rect)
        }
    }
}
