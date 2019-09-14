import Combine
import Foundation
import SwiftUI

class PostModel: Codable, Identifiable {

#if LOCAL_ENDPOINT
  static var baseUrl = "http://localhost:1313/"
#else
  static var baseUrl = "https://swiftui.diegolavalle.com/"
#endif

  static var url = URL(string: "\(baseUrl)posts/index.json")!

  class ParamsModel: Codable {
    var tags: [String]
    var twitter: String
    var featured: Bool
    var hasDemo: Bool

    init() {
      tags = []
      twitter = "@"
      featured = false
      hasDemo = false
    }
  }

  class ResourceModel: Codable {
    var name: String
    var permalink: String
  }

  static func fetchAll(promise: @escaping (Future<[PostModel], APIError>.Promise)) -> () {
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

  var id: String {
    relPermalink
  }

  var title: String
  var permalink: String
  var relPermalink: String
  var slug: String
  var sectionsPath: String
  var draft: Bool
  var date: Date
  var lastmod: String
  var publishDate: String
  var expiryDate: String
  var plainSummary: String
  var truncated: Bool
  var params: ParamsModel
  var images: [ResourceModel]

  private init() {
    title = "Hello World"
    permalink = "https://host.local/posts/hello-world"
    relPermalink = "/posts/hello-world"
    slug = "hello-world"
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
    images = []
  }

  static var specimen: PostModel {
    let post = PostModel()
    return post
  }
}

class PostImageManager {

  var post: PostModel
  
  init(_ post: PostModel) {
    self.post = post
  }

  func imageUrl(_ name: String) -> URL {
    URL(string: post.images.first(where: {$0.name == name})!.permalink)!
  }

  var imageRequest = PassthroughSubject<String, APIError>()

  var imageResponse: AnyPublisher<Image, Never> {
    imageRequest
    .debounce(for: 0.5, scheduler: RunLoop.main)
    .removeDuplicates()
    .flatMap { imageName in
      Future { ImageModel.fetch(withUrl: self.imageUrl(imageName), promise: $0) }
    }
    .receive(on: DispatchQueue.main)
    .catch { e in
      Optional.Publisher(nil)
    }
    .eraseToAnyPublisher()
  }
}
