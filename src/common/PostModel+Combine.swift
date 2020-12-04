import Combine
import Foundation

extension PostModel {

  static let url = URL(string: "\(AppData.baseUrl)posts/index.json")!

  static var postsPublisher: AnyPublisher<[PostModel]?, Never> {
    URLSession.shared
    .dataTaskPublisher(for: url)
    .map(\.data)
    .decode(type: [PostModel]?.self, decoder: decoder)
    .replaceError(with: nil)
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
  }

  var detailsPublisher: AnyPublisher<PostModel?, Never> {
    URLSession.shared
    .dataTaskPublisher(for: URL(string: "\(permalink)index.json")!)
    .map(\.data)
    .decode(type: PostModel?.self, decoder: Self.decoder)
    .replaceError(with: nil)
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
