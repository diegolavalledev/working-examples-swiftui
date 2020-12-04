import Foundation



import Combine
import CoreGraphics

struct ImageModel: Codable, Hashable {

  var name: String
  var permalink: String
  var width: CGFloat
  var height: CGFloat

  var url: URL {
    URL(string: permalink)!
  }

  static let sample = ImageModel(
    name: "feature",
    permalink: "http://localhost:1313/posts/no-uiiimage/icons.png",
    width: 400,
    height: 300
  )
}

extension ImageModel {

  var publisher: AnyPublisher<CGImage?, Never> {
    URLSession.shared
    .dataTaskPublisher(for: url)
    .print()
    .map(\.data)
    .map {
      CGImage(pngDataProviderSource: CGDataProvider(data: $0 as CFData)!, decode: nil, shouldInterpolate: true, intent: .perceptual)
    }
    .replaceError(with: nil)
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
