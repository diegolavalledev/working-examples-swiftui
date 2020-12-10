import Foundation

struct PostModel: Codable, Identifiable, Hashable {

  static let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  var id: String {
    relPermalink
  }

  let title: String
  let subtitle: String
  let permalink: String
  let relPermalink: String
  let slug: String
  let sectionsPath: String
  let draft: Bool
  let date: Date
  let lastmod: String
  let publishDate: String
  let expiryDate: String
  let plainSummary: String
  let truncated: Bool
  let params: Params
  let images: [ImageModel]

  static let sample = PostModel(
    title: "Hello, World!",
    subtitle: "Greeting Planet Earth",
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
    params: Params(tags: [], twitter: "@jack", featured: false, example: nil),
    images: []
  )
  
  var coverImage: ImageModel? {
    images.first(where: {$0.name == "cover"})
  }
}
