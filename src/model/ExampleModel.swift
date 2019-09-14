import Combine
import Foundation
import SwiftUI

class ExampleModel: Codable, Identifiable {

#if LOCAL_ENDPOINT
  static var baseUrl = "http://localhost:1313/"
#else
  static var baseUrl = "https://swiftui.diegolavalle.com/"
#endif

  static var url = URL(string: "\(baseUrl)examples/index.json")!

  static var cancellable: AnyCancellable?
   
  static func fetchAll(promise: @escaping (Future<[ExampleModel], APIError>.Promise)) -> () {
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
          let posts = try jsonDecoder.decode([ExampleModel].self, from: data)
          promise(.success(posts))
        } catch {
          print("\(error)")
          promise(.failure(.networkError))
        }
    }
  }

  var id: String {
    relPermalink
  }

  var title: String
  var subtitle: String
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
  var images: [Resource]

  private init(
    title: String,
    subtitle: String,
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
    images: [Resource]
  ) {
    self.title = title
    self.subtitle = subtitle
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
    self.images = images
  }

  static var specimen: ExampleModel {
    ExampleModel(
      title: "Hello World",
      subtitle: "How are you doing?",
      permalink: "https://host.local/examples/hello-world",
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
      images: []
    )
  }
  
  var featureImage: Resource {
    images.first(where: {$0.name == "feature"})!
  }
}
