import Combine
import Foundation

class AppData: ObservableObject {

#if LOCAL_ENDPOINT
  static let baseUrl = "http://localhost:1313/"
#else
  static let baseUrl = "https://swiftui.diegolavalle.com/"
#endif

  static let url = URL(string: "\(baseUrl)examples/index.json")!

  @Published var posts = [PostModel]?.none
  @Published var examples = [ExampleModel]?.none {
    didSet {
      if
        let examples = examples,
        let userDefaults = UserDefaults(suiteName: "group.com.diegolavalle.swiftui.app"),
        let examplesJson = try? JSONEncoder().encode(examples)
      {
        userDefaults.setValue(examplesJson, forKey: "examples")
      }
    }
  }

  // Ongoing data tasks
  private var postsTask: AnyCancellable?
  private var examplesTask: AnyCancellable?
  
  // Data task publisher for fetching all airports (stations)
  private var examplesPublisher: AnyPublisher<[ExampleModel]?, Never> {
    URLSession.shared
    .dataTaskPublisher(for: AppData.url)
    .map(\.data)
    .decode(type: [ExampleModel]?.self, decoder: ExampleModel.decoder)
    .replaceError(with: nil)
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
  }

  /// Creates an instanse of the store which fetches stations immediatelly
  init() {
    // We fetch everything on launch
    postsTask = PostModel.postsPublisher.assign(to: \.posts, on: self)
    examplesTask = examplesPublisher.assign(to: \.examples, on: self)
  }

  func reloadExamples() {
    examples = nil
    examplesTask = examplesPublisher.assign(to: \.examples, on: self)
  }
}
