import UIKit

final class ChannelsBarHeaderView: UIView {
    
  let allView: ChannelsBarView = {
    let view = ChannelsBarView()
    view.barLabel.text = "Все"
    view.state = .selected
    return view
  }()
  
  let favoriteView: ChannelsBarView = {
    let view = ChannelsBarView()
    view.barLabel.text = "Избранные"
    view.state = .nonSelected
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupInitialLayout() {
    addSubview(allView)
    addSubview(favoriteView)
    
    allView.translatesAutoresizingMaskIntoConstraints = false
    allView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
    allView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    allView.trailingAnchor.constraint(equalTo: self.favoriteView.leadingAnchor, constant: -12).isActive = true
    allView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
    allView.widthAnchor.constraint(equalToConstant: allView.barLabel.intrinsicContentSize.width + 32).isActive = true
    
    favoriteView.translatesAutoresizingMaskIntoConstraints = false
    favoriteView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
    favoriteView.leadingAnchor.constraint(equalTo: self.allView.trailingAnchor).isActive = true
    favoriteView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
    favoriteView.widthAnchor.constraint(equalToConstant: favoriteView.barLabel.intrinsicContentSize.width + 32).isActive = true
  }
}
