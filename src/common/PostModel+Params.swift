extension PostModel {
  struct Params: Codable, Hashable {
    let tags: [String]
    let twitter: String
    let featured: Bool
    let example: String?

    var hasDemo: Bool {
      example != nil
    }
  }
}
