import UIKit

public final class StackViewBuilder {
  
  private var stackView = UIStackView()
  
  public func with(subviews: [UIView]) -> Self {
    stackView = UIStackView(arrangedSubviews: subviews)
    return self
  }
  
  public func vertical() -> Self {
    stackView.axis = .vertical
    return self
  }
  
  public func horizontal() -> Self {
    stackView.axis = .horizontal
    return self
  }
  
  public func spaced(_ spacing: CGFloat) -> Self {
    stackView.spacing = spacing
    return self
  }
  
  public func with(axis: NSLayoutConstraint.Axis) -> Self {
    stackView.axis = axis
    return self
  }
  
  public func with(alignment: UIStackView.Alignment) -> Self {
    stackView.alignment = alignment
    return self
  }
  
  public func with(distribution: UIStackView.Distribution) -> Self {
    stackView.distribution = distribution
    return self
  }
  
  public func with(spacing: CGFloat, after view: UIView) -> Self {
    stackView.setCustomSpacing(spacing, after: view)
    return self
  }
  
  public func with(backgroundColor: UIColor) -> Self {
    stackView.backgroundColor = backgroundColor
    return self
  }
  
  public func build() -> UIStackView {
    stackView
  }
}

public extension Array where Element: UIView {
  
  func toHorizontalStackView() -> StackViewBuilder {
    StackViewBuilder().with(subviews: self)
  }
  
  func toVerticalStackView() -> StackViewBuilder {
    StackViewBuilder().with(subviews: self)
      .vertical()
  }
}
