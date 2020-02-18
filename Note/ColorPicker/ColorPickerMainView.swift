import UIKit

@IBDesignable
final class ColorPickerMainView: UIView {

    var currentColor: UIColor = UIColor.white

    @IBOutlet weak var container: UIView!

    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var colorCode: UILabel!

    @IBOutlet weak var gradientView: ColorPickerView!
    @IBOutlet weak var pointer: PointerView!
    
    weak var delegate: Colorable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        pointer.center = gradientView.getPointForColor(color: currentColor)
        preview.backgroundColor = currentColor
        
    }

    private func setup(_ view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 5
    }

    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        setup(container)
        setup(gradientView)

    }

    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ColorPickerMainView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }

    private func update(_ location: CGPoint) {
        let x = min(max(0, location.x), gradientView.frame.width)
        let y = min(max(0, location.y), gradientView.frame.height)
        let rightLocation = CGPoint(x: x, y: y)
        currentColor = gradientView.getColorAtPoint(point: rightLocation)
        preview.backgroundColor = currentColor
        pointer.center = rightLocation
        pointer.fillColor = currentColor
        
        colorCode.text = currentColor.htmlRGBaColor
        
        delegate?.passValue(of: currentColor)
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
