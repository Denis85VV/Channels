import UIKit

struct Channel: Decodable {
  let id: Int
  let nameRu: String
  let imageURL: URL
  let current: CurrentBroadcast
  let videoURL: URL
  var isFavorited: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case nameRu = "name_ru"
    case imageURL = "image"
    case current
    case videoURL = "url"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try values.decode(Int.self, forKey: .id)
    self.nameRu = try values.decode(String.self, forKey: .nameRu)
    self.imageURL = try values.decode(URL.self, forKey: .imageURL)
    self.current = try values.decode(CurrentBroadcast.self, forKey: .current)
    self.videoURL = try values.decode(URL.self, forKey: .videoURL)
    self.isFavorited = CoreDataHandler().fetchIntItems().contains(self.id)
  }
}

struct ChannelList: Decodable {
  let channels: [Channel]
}

struct CurrentBroadcast: Decodable {
  let title: String
}
