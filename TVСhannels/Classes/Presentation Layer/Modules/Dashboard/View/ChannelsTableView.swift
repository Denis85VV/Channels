import UIKit

final class ChannelsTableView: UIView {
  
  let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: DashboardViewController.channelCell)
    table.register(ChannelsTableViewCell.self, forCellReuseIdentifier: ChannelsTableViewCell.Constants.channelCell)
    table.separatorStyle = .none
    table.backgroundColor = .x232427
    table.contentInset = UIEdgeInsets(top: Constants.tableViewTopInset, left: 0, bottom: 0, right: 0)
    table.scrollIndicatorInsets = UIEdgeInsets(top: Constants.tableViewTopInset, left: 0, bottom: 0, right: 0)
    return table
  }()
  
  let headerView: ChannelsBarHeaderView = {
    let view = ChannelsBarHeaderView()
    view.backgroundColor = .x343438
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
    addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    addSubview(headerView)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
}

private extension ChannelsTableView {
  enum Constants {
    static let tableViewTopInset: CGFloat = 72
  }
}
