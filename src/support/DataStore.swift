import Foundation
import Combine

class DataStore: ObservableObject {
  
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
}
