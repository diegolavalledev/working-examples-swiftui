import Combine
import Foundation

class PostModel: Codable, Identifiable {
  
  class ParamsModel: Codable {
    var tags: [String]?
    var twitter: String?
  }

  class ResourceModel: Codable {
    var name: String?
  }

  static func fetchAll(promise: @escaping (Future<[PostModel], APIError>.Promise)) -> () {
    if let url = URL(string: "https://swiftui.diegolavalle.com/posts/index.json") {
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
          print("\(error)")
          promise(.failure(.networkError))
          return
        }
        if let response = response as? HTTPURLResponse, response.statusCode == 404 {
          promise(.failure(.notFound))
          return
        }
        guard let data = data else {
          promise(.failure(.networkError))
          return
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        do {
          let posts = try jsonDecoder.decode([PostModel].self, from: data)
          promise(.success(posts))
        } catch {
          print("\(error)")
          promise(.failure(.networkError))
        }
      }.resume()
    }
  }

  var id: String {
    relPermalink
  }

  var title: String
  var permalink: String
  var relPermalink: String
  var sectionsPath: String
  var draft: Bool
  var date: Date
  var lastmod: String
  var publishDate: String
  var expiryDate: String
  var plainSummary: String
  var truncated: Bool
  var params: ParamsModel
  var resources: [ResourceModel]

  private init() {
    title = "Hello World"
    permalink = "https://host.local/posts/hello-world"
    relPermalink = "/posts/hello-world"
    sectionsPath = "posts"
    draft = false
    date = Date()
    lastmod = ""
    publishDate = ""
    expiryDate = ""
    plainSummary = """
      Hello,
      World.
    """
    truncated = true
    params = ParamsModel()
    resources = []
  }

  static var specimen: PostModel {
    let post = PostModel()
    return post
  }
}
