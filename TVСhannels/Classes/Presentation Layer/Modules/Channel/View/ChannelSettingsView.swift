import UIKit

final class ChannelSettingsView: UIView {
  
  var stackView = UIStackView()
  
  private lazy var firstView: UIView = {
    let view = Self.makeCellView(text: "1080p", state: .nonSelected)
    return view
  }()
  
  private lazy var secondView: UIView = {
    let view = Self.makeCellView(text: "720p", state: .nonSelected)
    return view
  }()
  
  private lazy var thirdView: UIView = {
    let view = Self.makeCellView(text: "480p", state: .nonSelected)
    return view
  }()
  
  private lazy var fourthView: UIView = {
    let view = Self.makeCellView(text: "360p", state: .nonSelected)
    return view
  }()
  
  private lazy var fifthView: UIView = {
    let view = Self.makeCellView(text: "AUTO", state: .selected)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
  }
  
  static func makeCellView(text: String, state: State) -> UIView {
    let view = UIView()
    
    let textLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 16)
      label.textColor = .x1A1C23
      label.alpha = 0.7
      label.text = text
      label.textAlignment = .center
      return label
    }()
    
    if state == .selected {
      textLabel.textColor = state.textColor
      textLabel.font = state.font
      textLabel.alpha = state.alpha
      view.backgroundColor = state.backgroundColor
    } else {
      textLabel.textColor = state.textColor
      textLabel.font = state.font
      textLabel.alpha = state.alpha
      view.backgroundColor = state.backgroundColor
    }
    
    view.addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
    textLabel.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
    
    return view
  }
  
  private func setupInitialLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 200).isActive = true
    widthAnchor.constraint(equalToConstant: 128).isActive = true
    
    stackView = [firstView, secondView, thirdView, fourthView, fifthView]
      .toVerticalStackView()
      .with(alignment: .fill)
      .with(distribution: .fillEqually)
      .spaced(1)
      .build()
    
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.leadingAnchor.constraint(equalTo:self.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

extension ChannelSettingsView {
  enum State {
    case selected
    case nonSelected
    
    var backgroundColor: UIColor {
      switch self {
      case .selected:
        return .blue
      case .nonSelected:
        return .white
      }
    }
    
    var textColor: UIColor {
      switch self {
      case .selected:
        return .white
      case .nonSelected:
        return .x1A1C23
      }
    }
    
    var alpha: CGFloat {
      switch self {
      case .selected:
        return 1
      case .nonSelected:
        return 0.7
      }
    }
    
    var font: UIFont {
      switch self {
      case .selected:
        return UIFont.boldSystemFont(ofSize: 16)
      case .nonSelected:
        return UIFont.systemFont(ofSize: 16)
      }
    }
  }
}

