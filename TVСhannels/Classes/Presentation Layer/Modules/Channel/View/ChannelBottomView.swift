import UIKit

final class ChannelBottomView: UIView {
  
  private let progressGradientView: GradientView = {
    let view = GradientView()
    view.colors = [.x00FFFF, .x2A90FC]
    view.angle = 270
    view.locations = [0, 1]
    return view
  }()
  
  let settingsIconView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.image = UIImage(named: "gear")
    view.isUserInteractionEnabled = true
    return view
  }()
  
  let sliderProgressBar: UISlider = {
    let slider = UISlider()
    slider.minimumValue = 0
    slider.maximumTrackTintColor = .x808185
    slider.thumbTintColor = .clear
    slider.layer.cornerRadius = 2.5
    slider.layer.masksToBounds = true
    return slider
  }()
  
  let timeLeftLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor =  .white
    label.textAlignment = .left
    return label
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func setupInitialLayout() {    
    addSubview(sliderProgressBar)
    addSubview(timeLeftLabel)
    addSubview(settingsIconView)
    
    heightAnchor.constraint(equalToConstant: 55).isActive = true
    
    progressGradientView.frame = sliderProgressBar.frame
    sliderProgressBar.setMinimumTrackImage(progressGradientView.asImage(), for: .normal)
    
    sliderProgressBar.translatesAutoresizingMaskIntoConstraints = false
    sliderProgressBar.leadingAnchor.constraint(equalTo:self.leadingAnchor).isActive = true
    sliderProgressBar.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
    sliderProgressBar.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
    
    timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLeftLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor).isActive = true
    timeLeftLabel.trailingAnchor.constraint(equalTo:self.settingsIconView.leadingAnchor, constant: -8).isActive = true
    timeLeftLabel.bottomAnchor.constraint(equalTo:self.sliderProgressBar.topAnchor, constant: -1).isActive = true
    
    settingsIconView.translatesAutoresizingMaskIntoConstraints = false
    settingsIconView.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
    settingsIconView.leadingAnchor.constraint(equalTo:self.timeLeftLabel.trailingAnchor).isActive = true
    settingsIconView.bottomAnchor.constraint(equalTo:self.sliderProgressBar.topAnchor, constant: 1).isActive = true
    settingsIconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    settingsIconView.heightAnchor.constraint(equalToConstant: 24).isActive = true
  }
}
