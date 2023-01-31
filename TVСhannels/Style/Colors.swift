import UIKit

public extension UIColor {
  
  static let x232427 = UIColor(hex: 0x232427)
  static let x404247 = UIColor(hex: 0x404247)
  static let x343438 = UIColor(hex: 0x343438)
  static let x808185 = UIColor(hex: 0x808185)
  static let x0077FF = UIColor(hex: 0x0077FF)
  static let x00FFFF = UIColor(hex: 0x00FFFF)
  static let x2A90FC = UIColor(hex: 0x2A90FC)
  static let x0E0F0F = UIColor(hex: 0x0E0F0F)
  static let x5B6870 = UIColor(hex: 0x5B6870)
  static let x1A1C23 = UIColor(hex: 0x1A1C23)
  static let xD8E1E6 = UIColor(hex: 0xD8E1E6)
}

public extension UIColor {
  
  convenience init(hex: UInt32) {
    self.init(
      red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(hex & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
