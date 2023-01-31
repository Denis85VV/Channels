import UIKit

final class ChannelsBarView: UIView {
  
  public var state: State = .selected {
    didSet {
      barLabel.textColor = state.barTextColor
      lineView.backgroundColor = state.lineBackgroundColor
      isUserInteractionEnabled = state.isEnabled
    }
  }
  
  let barLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    return label
  }()
  
  let lineView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupInitialLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupInitialLayout() {
    heightAnchor.constraint(equalToConstant: 38).isActive = true
    
    addSubview(lineView)
    lineView.translatesAutoresizingMaskIntoConstraints = false
    lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    addSubview(barLabel)
    barLabel.translatesAutoresizingMaskIntoConstraints = false
    barLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    barLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    barLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -16).isActive = true

  }
}

extension ChannelsBarView {
  
  enum State {
    case selected
    case nonSelected
    
    var lineBackgroundColor: UIColor {
      switch self {
      case .selected:
        return .x0077FF
      case .nonSelected:
        return .clear
      }
    }
    
    var barTextColor: UIColor {
      switch self {
      case .selected:
        return .white
      case .nonSelected:
        return .x808185
      }
    }
    
    var isEnabled: Bool {
      switch self {
      case .selected:
        return false
      case .nonSelected:
        return true
      }
    }
  }
}
