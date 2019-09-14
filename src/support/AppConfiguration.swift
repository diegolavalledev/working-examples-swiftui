import Combine

class AppConfiguration: ObservableObject {

  enum Tab {
    case posts
    case examples
    case favorites
    case search
  }

  @Published var tab: Tab = .posts
  @Published var postSlug: String?
  @Published var exampleSlug: String?
}
