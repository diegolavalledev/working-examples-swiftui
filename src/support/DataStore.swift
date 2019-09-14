import Foundation
import Combine

class DataStore: ObservableObject {

  enum DefaultKeys: String {
    case favoritePosts = "posts.favorites"
  }

  var favorites: [String] {
    get {
      guard let favorites = UserDefaults.standard.stringArray(forKey: DefaultKeys.favoritePosts.rawValue) else {
        return []
      }
      return favorites
    }
    
    set {
      UserDefaults.standard.set(
        newValue,
        forKey: DefaultKeys.favoritePosts.rawValue
      )
      UserDefaults.standard.synchronize()
    }
  }
  
  var postsRequest = PassthroughSubject<String, APIError>()

  var posts: AnyPublisher<[PostModel], Never> {
    postsRequest
    // Trying to prevent a second consequtive request from the View.onAppear()
    .throttle(for: .seconds(0.5), scheduler: RunLoop.main, latest: true)
    //.debounce(for: 0.5, scheduler: RunLoop.main)
    .removeDuplicates()
    .flatMap { _ in
      Future { PostModel.fetchAll(promise: $0) }
    }
    .receive(on: DispatchQueue.main)
    .catch { e in
      Optional.Publisher(nil)
    }
    .eraseToAnyPublisher()
  }

  var examplesRequest = PassthroughSubject<String, APIError>()

  var examples: AnyPublisher<[ExampleModel], Never> {
    examplesRequest
    // Trying to prevent a second consequtive request from the View.onAppear()
    .throttle(for: .seconds(0.5), scheduler: RunLoop.main, latest: true)
    //.debounce(for: 0.5, scheduler: RunLoop.main)
    .removeDuplicates()
    .flatMap { _ in
      Future { ExampleModel.fetchAll(promise: $0) }
    }
    .receive(on: DispatchQueue.main)
    .catch { e in
      Optional.Publisher(nil)
    }
    .eraseToAnyPublisher()
  }
}
