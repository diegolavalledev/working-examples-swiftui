extension Array where Element == ExampleModel {
  func findBySlug(_ slug: String) -> ExampleModel? {
    first { $0.slug == slug }
  }
}
