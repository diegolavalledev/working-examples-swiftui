import Combine
import Foundation

class AppData: ObservableObject {

#if LOCAL_ENDPOINT
  static let baseUrl = "http://localhost:1313/"
#else
  static let baseUrl = "https://swiftui.diegolavalle.com/"
#endif

  static let url = URL(string: "\(baseUrl)examples/index.json")!
  
  // TODO: Move to examplesPublisher publisher
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
  private var examplesTask: AnyCancellable?

  func reloadExamples() {
    examples = nil
    examplesTask = ExampleModel.examplesPublisher.assign(to: \.examples, on: self)
  }
}
