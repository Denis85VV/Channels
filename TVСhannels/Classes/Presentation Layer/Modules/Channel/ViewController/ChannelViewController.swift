import UIKit
import AVKit
import AVFoundation

class ChannelViewController: UIViewController {
  
  private var player = AVPlayer()
  private var playerLayer = AVPlayerLayer()
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.tintColor = .white
    view.color = .white
    return view
  }()
  
  var channelView: ChannelView? {
    view as? ChannelView
  }
  
  private var channelName: String
  private var broadcastName: String
  private var channelImageURL: URL
  private var broadcastURL: URL
  
  init(
    channelName: String,
    broadcastName: String,
    channelImageURL: URL,
    broadcastURL: URL
  ) {
    self.channelName = channelName
    self.broadcastName = broadcastName
    self.channelImageURL = channelImageURL
    self.broadcastURL = broadcastURL
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = ChannelView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    
    channelView?.channelHeaderView.channelImageView.setAsyncImage(url: channelImageURL)
    channelView?.channelHeaderView.channelLabel.text = channelName
    channelView?.channelHeaderView.broadcastLabel.text = broadcastName
    
    channelView?.channelBottomView.settingsIconView.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(onSettingsTap)
      )
    )
    channelView?.channelHeaderView.backImageView.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(onBackTap)
      )
    )
    
    let mockUrlString =  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    guard let url = URL(string: mockUrlString) else { return }
    setupPlayer(url: url)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    playerLayer.frame = view.frame
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "currentItem.loadedTimeRanges" {
      activityIndicatorView.stopAnimating()
      player.play()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    if touches.first?.view != channelView?.channelSettingsView {
      channelView?.channelSettingsView.isHidden = true
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AppUtility.lockOrientation(.landscape)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    AppUtility.lockOrientation(.all)
  }
  
  private func setupPlayer(url: URL) {
    activityIndicatorView.startAnimating()
    
    player = AVPlayer(url: url)
    player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
    player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    
    addTimeObserver()
    
    playerLayer = AVPlayerLayer(player: player)
    playerLayer.videoGravity = .resizeAspectFill
    channelView?.videoView.layer.addSublayer(playerLayer)
    
    setupPlayButtonInsideVideoView()
  }
  
  private func addTimeObserver() {
    let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    let mainQueue = DispatchQueue.main
    player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) { [weak self] time in
      guard let currentItem = self?.player.currentItem else { return }
      if self?.player.currentItem!.status == .readyToPlay {
        self?.channelView?.channelBottomView.sliderProgressBar.maximumValue = Float(currentItem.duration.seconds)
        self?.channelView?.channelBottomView.sliderProgressBar.value = Float(time.seconds)
        
        let timeLeft = CMTimeSubtract(currentItem.duration, time)
        self?.channelView?.channelBottomView.timeLeftLabel.text = "Осталось\(timeLeft.minuteText) минут"
      }
    }
  }
  
  private func setupPlayButtonInsideVideoView() {
    channelView?.videoView.addSubview(activityIndicatorView)
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.centerXAnchor.constraint(equalTo: (channelView?.videoView.centerXAnchor)!).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: (channelView?.videoView.centerYAnchor)!).isActive = true
  }
  
  @objc func onBackTap(_ sender: UIView) {
    navigationController?.popViewController(animated: true)
  }
  @objc func onSettingsTap(_ sender: UIView) {
    channelView?.channelSettingsView.isHidden = false
  }
}

private extension CMTime {
  var minuteText: String {
    let totalSeconds = CMTimeGetSeconds(self)
    let minutes: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
    return String(format: "%2i", minutes)
  }
}
