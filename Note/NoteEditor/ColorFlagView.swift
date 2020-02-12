import UIKit

@IBDesignable
class ColorFlagView: UIView {

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
        circlePath.lineWidth = 2
        circlePath.stroke()
        UIColor.white.setStroke()
        circlePath.lineWidth = 1
        circlePath.stroke()
        
        let path = UIBezierPath()
        path.lineWidth = 2
        path.move(to: CGPoint(x: rect.width/10, y: rect.height/10))
        path.addLine(to: CGPoint(x: rect.width/2, y: 9 * rect.height/10))
        path.addLine(to: CGPoint(x: 8 * rect.width/10, y: rect.width/10))
        UIColor.black.setStroke()
        path.stroke()
        UIColor.white.setStroke()
        path.lineWidth = 1
        path.stroke()
    }
}
