import UIKit

struct InstagramData: Codable {
  var data: [Data]
  struct Data: Codable {
    var id: Int
    var user: User
    struct User: Codable {
      var id: Int
      var full_name: String
    }
    var location: Location?
    struct Location: Codable {
      var latitude: Double
      var longitude: Double
    }
    var likes: Int
    var image: Image
    struct Image: Codable {
      var url: String
    }
  }
}

struct Instagram {
  static func fetchInstagramData(completion: @escaping (InstagramData) -> Swift.Void ) {
    guard let path = Bundle.main.path(forResource: "instagram", ofType: ".json") else {
      fatalError("Not Found : json file.")
    }
    guard let data = FileHandle(forReadingAtPath: path)?.readDataToEndOfFile() else  {
      fatalError("Could Not Read : json file.")
    }
    do {
      var instagram = try JSONDecoder().decode(InstagramData.self, from: data)
      instagram.data.sort { (i1, i2) in return i1.likes > i2.likes }
      completion(instagram)
    } catch {
      fatalError("Failed to parse. \(error)")
    }
  }
}
