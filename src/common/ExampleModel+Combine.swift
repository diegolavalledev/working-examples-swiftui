import Combine
import Foundation

extension ExampleModel {

  var detailsPublisher: AnyPublisher<ExampleModel?, Never> {
    URLSession.shared
    .dataTaskPublisher(for: URL(string: "\(permalink)index.json")!)
    .map(\.data)
    .decode(type: ExampleModel?.self, decoder: ExampleModel.decoder)
    .replaceError(with: nil)
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
