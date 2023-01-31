import UIKit

public class GradientView: UIView {

  private lazy var gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    layer.addSublayer(gradientLayer)
    gradientLayer.frame = bounds
    return gradientLayer
  }()

  public var colors: [UIColor]? {
    get { gradientLayer.colors?.compactMap { UIColor(cgColor: $0 as! CGColor) } }
    set { gradientLayer.colors = newValue?.compactMap { $0.cgColor } }
  }

  public var locations: [NSNumber]? {
    get { gradientLayer.locations }
    set { gradientLayer.locations = newValue }
  }

  public var opacity: Float {
    get { gradientLayer.opacity }
    set {
      if newValue < 0 {
        gradientLayer.opacity = newValue
      } else if newValue > 1 {
        gradientLayer.opacity = 1
      }
      gradientLayer.opacity = newValue
    }
  }

  public var angle: Float = 0.0 {
    didSet {
      let newAngle: Float = angle / 360.0
      let startPointX = powf(
        sinf(2 * Float.pi * ((newAngle + 0.75) / 2)),
        2
      )
      let startPointY = powf(
        sinf(2 * Float.pi * (newAngle / 2)),
        2
      )
      let endPointX = powf(
        sinf(2 * Float.pi * ((newAngle + 0.25) / 2)),
        2
      )
      let endPointY = powf(
        sinf(2 * Float.pi * ((newAngle + 0.5) / 2)),
        2
      )
      gradientLayer.endPoint = CGPoint(x: CGFloat(endPointX), y: CGFloat(endPointY))
      gradientLayer.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
}
