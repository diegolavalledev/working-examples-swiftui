import Combine
import Foundation
import SwiftUI

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

extension Resource {
  class Coordinator {

    var resource: Resource
    
    init(_ resource: Resource) {
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
