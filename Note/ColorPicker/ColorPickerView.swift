import UIKit

@IBDesignable
final class ColorPickerView: UIView {

    enum Constants {
        static let elementSize: CGFloat = 1.0
        static let saturationExponentTop:Float = 1.5
        static let saturationExponentBottom:Float = 0.75
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ColorPickerView.drawPallete(rect)
    }
    
    static func drawPallete(_ rect: CGRect,
                                   elementSize: CGFloat = Constants.elementSize,
                                   saturationExponentTop: Float = Constants.saturationExponentTop,
                                   saturationExponentBottom: Float = Constants.saturationExponentBottom) {
        let context = UIGraphicsGetCurrentContext()
        
        for y : CGFloat in stride(from: 0.0 ,to: rect.height, by: elementSize) {
            var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
            saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = y <= rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
            for x : CGFloat in stride(from: 0.0 ,to: rect.width, by: elementSize) {
                let hue = x / rect.width
                let color = UIColor(hue: hue,
                                    saturation: saturation,
                                    brightness: brightness,
                                    alpha: 1.0)
                context!.setFillColor(color.cgColor)
                context!.fill(CGRect(x: x, y: y,
                                     width: elementSize,
                                     height: elementSize))
            }
        }
    }
    
    func getColorAtPoint(point: CGPoint) -> UIColor {
        let roundedPoint = CGPoint(x: Constants.elementSize * CGFloat(Int(point.x / Constants.elementSize)),
                                   y: Constants.elementSize * CGFloat(Int(point.y / Constants.elementSize)))
        var saturation = roundedPoint.y < self.bounds.height / 2.0 ? CGFloat(2 * roundedPoint.y) / self.bounds.height
            : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        saturation = CGFloat(powf(Float(saturation), roundedPoint.y < self.bounds.height / 2.0 ? Constants.saturationExponentTop : Constants.saturationExponentBottom))
        let brightness = roundedPoint.y <= self.bounds.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        let hue = roundedPoint.x / self.bounds.width
        return UIColor(hue: hue,
                       saturation: saturation,
                       brightness: brightness,
                       alpha: 1.0)
    }
    
    func getPointForColor(color: UIColor) -> CGPoint {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil);
        
        var yPos:CGFloat = 0
        let halfHeight = (self.bounds.height / 2)
        if (brightness >= 0.99) {
            let percentageY = powf(Float(saturation), 1.0 / Constants.saturationExponentTop)
            yPos = CGFloat(percentageY) * halfHeight
        } else {
            yPos = halfHeight + halfHeight * (1.0 - brightness)
        }
        let xPos = hue * self.bounds.width
        return CGPoint(x: xPos, y: yPos)
    }
}
