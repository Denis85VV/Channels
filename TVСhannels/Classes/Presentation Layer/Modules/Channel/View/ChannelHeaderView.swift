import UIKit

final class ChannelHeaderView: UIView {
  
  private let container: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    return view
  }()
  
  let channelImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.layer.cornerRadius = 4
    view.clipsToBounds = true
    return view
  }()
  
  let backImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    view.image = UIImage(named: "arrow")
    return view
  }()
  
  let broadcastLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 19)
    label.textColor =  .white
    return label
  }()
  
  let channelLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .white
    label.alpha = 0.8
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func setupInitialLayout() {
    addSubview(backImageView)
    addSubview(channelImageView)
    addSubview(container)
    container.addSubview(channelLabel)
    container.addSubview(broadcastLabel)
    
    heightAnchor.constraint(equalToConstant: 44).isActive = true
     
    backImageView.translatesAutoresizingMaskIntoConstraints = false
    backImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    backImageView.trailingAnchor.constraint(equalTo: self.channelImageView.leadingAnchor, constant: -16).isActive = true
    backImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    backImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    channelImageView.translatesAutoresizingMaskIntoConstraints = false
    channelImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    channelImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    channelImageView.leadingAnchor.constraint(equalTo: self.backImageView.trailingAnchor).isActive = true
    channelImageView.trailingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: -24).isActive = true
    
    container.translatesAutoresizingMaskIntoConstraints = false
    container.leadingAnchor.constraint(equalTo: self.channelImageView.trailingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    container.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    broadcastLabel.translatesAutoresizingMaskIntoConstraints = false
    broadcastLabel.topAnchor.constraint(equalTo: self.container.topAnchor).isActive = true
    broadcastLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor).isActive = true
    broadcastLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor).isActive = true
    
    channelLabel.translatesAutoresizingMaskIntoConstraints = false
    channelLabel.topAnchor.constraint(equalTo: self.broadcastLabel.bottomAnchor).isActive = true
    channelLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor).isActive = true
    channelLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor).isActive = true
  }
}
