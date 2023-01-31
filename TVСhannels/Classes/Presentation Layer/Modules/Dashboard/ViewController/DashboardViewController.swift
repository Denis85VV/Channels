import UIKit

// TODO: Добавить ActivityIndicator

final class DashboardViewController: UIViewController {
  static let channelCell = "ChannelCell"
  
  private var channelsList = [Channel]()
  private var favoriteList = [Channel]()
  private let dataHandler = CoreDataHandler()
  private var rootTableView: ChannelsTableView? {
    view as? ChannelsTableView
  }
  
  override func loadView() {
    view = ChannelsTableView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    
    rootTableView?.tableView.delegate = self
    rootTableView?.tableView.dataSource = self
    
    rootTableView?.headerView.allView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectTap)))
    rootTableView?.headerView.favoriteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectTap)))
    
    downloadChannels()
  }
  
  @objc func onSelectTap() {
    if rootTableView?.headerView.allView.state == .selected {
      rootTableView?.headerView.allView.state = .nonSelected
      rootTableView?.headerView.favoriteView.state = .selected
    } else {
      rootTableView?.headerView.allView.state = .selected
      rootTableView?.headerView.favoriteView.state = .nonSelected
    }
    downloadChannels()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AppUtility.lockOrientation(.portrait)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    AppUtility.lockOrientation(.all)
  }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return Constants.numberOfSections
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.heightForRowAt
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if rootTableView?.headerView.favoriteView.state  == .nonSelected {
      return channelsList.count
    } else {
      return favoriteList.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableViewCell.Constants.channelCell, for: indexPath) as! ChannelsTableViewCell
    cell.delegate = self
    
    if rootTableView?.headerView.favoriteView.state  == .nonSelected {
      cell.channelLabel.text = channelsList[indexPath.row].nameRu
      cell.broadcastLabel.text = channelsList[indexPath.row].current.title
      cell.channelImageView.setAsyncImage(url: channelsList[indexPath.row].imageURL)
      cell.favoriteIconImageView.image = dataHandler.fetchIntItems().contains(channelsList[indexPath.row].id) ? UIImage(named: "favorite_icon_enabled") : UIImage(named: "favorite_icon_disabled")
    } else {
      cell.channelLabel.text = favoriteList[indexPath.row].nameRu
      cell.broadcastLabel.text = favoriteList[indexPath.row].current.title
      cell.channelImageView.setAsyncImage(url: favoriteList[indexPath.row].imageURL)
      cell.favoriteIconImageView.image = dataHandler.fetchIntItems().contains(favoriteList[indexPath.row].id) ? UIImage(named: "favorite_icon_enabled") : UIImage(named: "favorite_icon_disabled")
    }
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    var currentSelectedChannelLabel: String
    var currentSelectedBroadcastLabel: String
    var currentSelectedImage: URL
    var currentSelectedBroadcastUrl: URL
    
    if rootTableView?.headerView.favoriteView.state  == .nonSelected {
      currentSelectedChannelLabel = channelsList[indexPath.row].nameRu
      currentSelectedBroadcastLabel = channelsList[indexPath.row].current.title
      currentSelectedImage = channelsList[indexPath.row].imageURL
      currentSelectedBroadcastUrl = channelsList[indexPath.row].videoURL
    } else {
      currentSelectedChannelLabel = favoriteList[indexPath.row].nameRu
      currentSelectedBroadcastLabel = favoriteList[indexPath.row].current.title
      currentSelectedImage = favoriteList[indexPath.row].imageURL
      currentSelectedBroadcastUrl = favoriteList[indexPath.row].videoURL
    }
    
    let channelViewController = ChannelViewController(
      channelName: currentSelectedChannelLabel,
      broadcastName: currentSelectedBroadcastLabel,
      channelImageURL: currentSelectedImage,
      broadcastURL: currentSelectedBroadcastUrl
    )
    self.navigationController?.pushViewController(channelViewController, animated: true)
  }
}

// MARK: ChannelsTableViewCellDelegate
extension DashboardViewController: ChannelsTableViewCellDelegate {
  
  func favoriteTap(cell: ChannelsTableViewCell) {
    guard let indexPathTapped = rootTableView?.tableView.indexPath(for: cell) else { return }
    
    if rootTableView?.headerView.favoriteView.state  == .nonSelected {
      let channel = channelsList[indexPathTapped.row]
      let isFavoritedTapped = channel.isFavorited
      channel.isFavorited ? dataHandler.deleteItem(id: channel.id) : dataHandler.saveItem(id: channel.id)
      channelsList[indexPathTapped.row].isFavorited = !isFavoritedTapped
    } else {
      let channel = favoriteList[indexPathTapped.row]
      let isFavoritedTapped = channel.isFavorited
      channel.isFavorited ? dataHandler.deleteItem(id: channel.id) : dataHandler.saveItem(id: channel.id)
      favoriteList[indexPathTapped.row].isFavorited = !isFavoritedTapped
    }
    rootTableView?.tableView.reloadRows(at: [indexPathTapped], with: .fade)
  }
}

// MARK: NetworkLayer and Constants
private extension DashboardViewController {
    // TODO: Вынести в отдельный сервис
  private func downloadChannels() {
    // TODO: Попробовать async await
    // TODO: Добавить обработку ошибок
    URLSession.shared.dataTask(with: Constants.url, completionHandler: { [weak self] data, response, error in
      guard let data = data, response != nil, error == nil else {
        print("ooops")
        return
      }
      let decoder = JSONDecoder()
      let channelList = try? decoder.decode(ChannelList.self, from: data)
      guard let downloadedChannelList = channelList else {
        return
      }
      self?.channelsList = downloadedChannelList.channels
      
      guard let fetchedData = self?.dataHandler.fetchIntItems() else { return }
      self?.favoriteList = downloadedChannelList.channels.filter({ channel in
        fetchedData.contains(where: { $0 == channel.id } )
      })
      DispatchQueue.main.async {
        self?.rootTableView?.tableView.reloadData()
      }
    }).resume()
  }
  
  enum Constants {
    static let numberOfSections: Int = 1
    static let heightForRowAt: CGFloat = 80
    static let url = URL(string: "http://limehd.online/playlist/channels.json")! // MARK: прикрыли лавочку))
  }
}
