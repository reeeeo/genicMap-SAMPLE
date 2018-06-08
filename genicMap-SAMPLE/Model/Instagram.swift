import UIKit

struct InstagramData: Codable {
  var user: User
  struct User: Codable {
    var id: String
    var full_name: String
  }
  var location: Location?
  struct Location: Codable {
    var latitude: Double
    var longitude: Double
    var name: String
  }
  var likes: Int
  var image: Image
  struct Image: Codable {
    var url: String
  }
}

