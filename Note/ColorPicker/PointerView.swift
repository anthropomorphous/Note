import UIKit

@IBDesignable
final class PointerView: UIView {
    
    var fillColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: rect.width/2, y: rect.height/2),
            radius: CGFloat( rect.width/2 - 2 ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true)
        UIColor.black.setStroke()
        circlePath.lineWidth = 3
        circlePath.stroke()
        if let fillColor = fillColor {
            fillColor.setFill()
            circlePath.fill()
        }
    }
}
