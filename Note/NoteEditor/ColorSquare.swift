import UIKit

@IBDesignable
final class ColorSquare: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setNeedsDisplay()
    }

}
