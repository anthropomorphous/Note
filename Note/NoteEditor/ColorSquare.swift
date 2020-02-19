import UIKit

class ColorSquare: UIView {

        
    @IBInspectable var isSelected: Bool = false
    @IBInspectable var isColorPallete: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
        if isSelected {
            setFlag(rect)
        }
        if isColorPallete {
            ColorPickerView.drawPallete(rect)
        }
    }
    
    private func setFlag(_ rect: CGRect) {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: rect.width/5, y: rect.height/5),
            radius: CGFloat( rect.width/6 - 2 ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true)
        UIColor.black.setStroke()
        circlePath.lineWidth = 3
        circlePath.stroke()
        UIColor.white.setStroke()
        circlePath.lineWidth = 2
        circlePath.stroke()
                
    }
    
    private func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    
}
