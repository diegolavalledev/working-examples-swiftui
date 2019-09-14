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

  static var cancellable: AnyCancellable?
   
  static func fetchAll2(promise: @escaping (Future<[PostModel], APIError>.Promise)) -> () {
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map {$0.data}
      .eraseToAnyPublisher()
      .sink(receiveCompletion: { status in
        switch status {
        case .failure(let error):
          print("\(error)")
          promise(.failure(.networkError))
        case .finished:
          break
        }
      })
      { data in
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        do {
          let posts = try jsonDecoder.decode([PostModel].self, from: data)
          promise(.success(posts))
        } catch {
          print("\(error)")
          promise(.failure(.networkError))
        }
    }
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
  var params: Params
  var images: [Resource]

  private init(
    title: String,
    permalink: String,
    relPermalink: String,
    slug: String,
    sectionsPath: String,
    draft: Bool,
    date: Date,
    lastmod: String,
    publishDate: String,
    expiryDate: String,
    plainSummary: String,
    truncated: Bool,
    params: Params,
    images: [Resource]
  ) {
    self.title = title
    self.permalink = permalink
    self.relPermalink = relPermalink
    self.slug = slug
    self.sectionsPath = sectionsPath
    self.draft = draft
    self.date = date
    self.lastmod = lastmod
    self.publishDate = publishDate
    self.expiryDate = expiryDate
    self.plainSummary = plainSummary
    self.truncated = truncated
    self.params = params
    self.images = images
  }

  static var specimen: PostModel {
    PostModel(
      title: "Hello World",
      permalink: "https://host.local/posts/hello-world",
      relPermalink: "/posts/hello-world",
      slug: "hello-world",
      sectionsPath: "posts",
      draft: false,
      date: Date(),
      lastmod: "",
      publishDate: "",
      expiryDate: "",
      plainSummary: """
        Hello,
        World.
      """,
      truncated: true,
      params: Params(),
      images: []
    )
  }
  
  var featureImage: Resource {
    images.first(where: {$0.name == "feature"})!
  }
}

extension PostModel {
  class Params: Codable {
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
}

extension PostModel {

  class Resource: Codable {
    var name: String
    var permalink: String
    var width: CGFloat
    var height: CGFloat

    var url: URL {
      URL(string: permalink)!
    }
    
    var coordinator: Coordinator {
      Coordinator(self)
    }

    static var specimen: Resource {
      Resource(
        name: "feature",
        permalink: "http://localhost:1313/posts/no-uiiimage/icons.png",
        width: 400,
        height: 300
      )
    }

    init(
      name: String,
      permalink: String,
      width: CGFloat,
      height: CGFloat
    ) {
      self.name = name
      self.permalink = permalink
      self.width = width
      self.height = height
    }
  }
}

extension PostModel.Resource {
  class Coordinator {

    var resource: PostModel.Resource
    
    init(_ resource: PostModel.Resource) {
      self.resource = resource
    }

    var requests = PassthroughSubject<String, APIError>()
    var responses: AnyPublisher<Image, Never> {
      requests
      .removeDuplicates()
      .flatMap { _ in
        Future { Image.fetch(fromUrl: self.resource.url, promise: $0) }
      }
      .receive(on: DispatchQueue.main)
      .catch { _ in
        Optional.Publisher(nil)
      }
      .eraseToAnyPublisher()
    }
  }
}
