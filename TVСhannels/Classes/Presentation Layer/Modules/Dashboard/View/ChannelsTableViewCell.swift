import UIKit

protocol ChannelsTableViewCellDelegate {
  func favoriteTap(cell: ChannelsTableViewCell)
}

final class ChannelsTableViewCell: UITableViewCell {
  
  var delegate: ChannelsTableViewCellDelegate?
  
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
  
  let channelLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .white
    return label
  }()
  
  let broadcastLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.textColor =  .white
    return label
  }()
  
  let favoriteIconImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.image = UIImage(named: "favorite_icon_disabled")
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupInitialLayout()
    
    favoriteIconImageView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(favoriteTap))
    )
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
  }
  
  private func setupInitialLayout() {
    backgroundColor = .clear
    self.contentView.backgroundColor = .x343438
    self.contentView.layer.cornerRadius = 10
    
    self.contentView.addSubview(channelImageView)
    container.addSubview(channelLabel)
    container.addSubview(broadcastLabel)
    self.contentView.addSubview(container)
    self.contentView.addSubview(favoriteIconImageView)
    
    self.contentView.heightAnchor.constraint(equalToConstant: 84).isActive = true
    
    channelImageView.translatesAutoresizingMaskIntoConstraints = false
    channelImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    channelImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 8).isActive = true
    channelImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    channelImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    container.translatesAutoresizingMaskIntoConstraints = false
    container.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo:self.channelImageView.trailingAnchor, constant: 16).isActive = true
    container.trailingAnchor.constraint(equalTo:self.favoriteIconImageView.leadingAnchor, constant: -20).isActive = true
    container.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    channelLabel.translatesAutoresizingMaskIntoConstraints = false
    channelLabel.topAnchor.constraint(equalTo:self.container.topAnchor, constant: 6).isActive = true
    channelLabel.leadingAnchor.constraint(equalTo:self.container.leadingAnchor).isActive = true
    channelLabel.trailingAnchor.constraint(equalTo:self.container.trailingAnchor).isActive = true
    
    broadcastLabel.translatesAutoresizingMaskIntoConstraints = false
    broadcastLabel.topAnchor.constraint(equalTo:self.channelLabel.bottomAnchor, constant: 8).isActive = true
    broadcastLabel.leadingAnchor.constraint(equalTo:self.container.leadingAnchor).isActive = true
    broadcastLabel.trailingAnchor.constraint(equalTo:self.container.trailingAnchor).isActive = true
    
    favoriteIconImageView.translatesAutoresizingMaskIntoConstraints = false
    favoriteIconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    favoriteIconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    favoriteIconImageView.leadingAnchor.constraint(equalTo:self.container.trailingAnchor).isActive = true
    favoriteIconImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -16).isActive = true
    favoriteIconImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
  }
  
  @objc func favoriteTap(_ sender: UIView) {
    delegate?.favoriteTap(cell: self)
  }
}

extension ChannelsTableViewCell {
  
  enum Constants {
    static let channelCell = "ChannelCell"
  }
}
