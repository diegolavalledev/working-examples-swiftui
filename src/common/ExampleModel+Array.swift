import Foundation

extension Array where Element == ExampleModel {

  func findBySlug(_ slug: String) -> ExampleModel? {
    first { $0.slug == slug }
  }

  func findByUrl(_ url: URL) -> ExampleModel? {
    let pathComponents = url.pathComponents

    guard pathComponents.count > 1 else {
      return nil
    }

    let name = pathComponents.count > 2 ? pathComponents[2] : pathComponents[1]

    if name == "latest", let example = first {
      return example
    } else if let example = first(where: { $0.slug == name }) {
      return example
    } else {
      return nil
    }
  }
}
