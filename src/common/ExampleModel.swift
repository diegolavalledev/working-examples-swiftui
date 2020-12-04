import Foundation

struct ExampleModel: Codable, Identifiable, Hashable {

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
  let images: [ImageModel]

  static let sample = ExampleModel(
    title: "Moonshot",
    subtitle: "Go to the moon with SwiftUI!",
    permalink: "https://swiftui.diegolavalle.com/examples/moonshot",
    relPermalink: "/examples/moonshot",
    slug: "moonshot",
    sectionsPath: "examples",
    draft: false,
    date: Date(),
    lastmod: "",
    publishDate: "",
    expiryDate: "",
    plainSummary: """
      Launch rocket.
      Reach moon.
    """,
    truncated: true,
    images: []
  )
  
  var iconImage: ImageModel {
    images.first(where: {$0.name == "icon"})!
  }
}
