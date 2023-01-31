import UIKit

final class ChannelView: UIView {
  
  let videoView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  let channelHeaderView = ChannelHeaderView()
  let channelBottomView = ChannelBottomView()
  
  let channelSettingsView: ChannelSettingsView = {
    let view = ChannelSettingsView()
    view.backgroundColor = .xD8E1E6
    view.layer.cornerRadius = 12
    view.clipsToBounds = true
    view.isHidden = true
    return view
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupInitialLayout() {
    backgroundColor = .black

    addSubview(videoView)
    videoView.translatesAutoresizingMaskIntoConstraints = false
    videoView.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
    videoView.leadingAnchor.constraint(equalTo:self.leadingAnchor).isActive = true
    videoView.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
    videoView.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
    
    addSubview(channelHeaderView)
    channelHeaderView.translatesAutoresizingMaskIntoConstraints = false
    channelHeaderView.topAnchor.constraint(equalTo:self.topAnchor, constant: 12).isActive = true
    channelHeaderView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
    channelHeaderView.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -10).isActive = true
    
    addSubview(channelBottomView)
    channelBottomView.translatesAutoresizingMaskIntoConstraints = false
    channelBottomView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 16).isActive = true
    channelBottomView.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -16).isActive = true
    channelBottomView.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -4).isActive = true
    
    addSubview(channelSettingsView)
    channelSettingsView.translatesAutoresizingMaskIntoConstraints = false
    channelSettingsView.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -16).isActive = true
    channelSettingsView.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -70).isActive = true
  }
}
