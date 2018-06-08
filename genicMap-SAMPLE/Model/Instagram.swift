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

struct Instagram {
  static func fetchInstagramData(completion: @escaping (InstagramData) -> Swift.Void ) {
    guard let path = Bundle.main.path(forResource: "instagram", ofType: ".json") else {
      fatalError("Not Found : json file.")
    }
    guard let data = FileHandle(forReadingAtPath: path)?.readDataToEndOfFile() else  {
      fatalError("Could Not Read : json file.")
    }
    do {
      let instagram = try JSONDecoder().decode(InstagramData.self, from: data)
      completion(instagram)
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}
