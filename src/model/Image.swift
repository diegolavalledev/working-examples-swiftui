import Combine
import SwiftUI
import UIKit

extension Image {
  static func fetch(fromUrl url: URL, promise: @escaping (Future<Image, APIError>.Promise)) -> () {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("\(error)")
        promise(.failure(.networkError))
        return
      }
      if let response = response as? HTTPURLResponse, response.statusCode == 404 {
        promise(.failure(.notFound))
        return
      }
      guard let data = data else {
        promise(.failure(.networkError))
        return
      }
      if let image = UIImage(data: data) {
        promise(.success(Image(uiImage: image)))
      } else {
        promise(.failure(.networkError))
      }
    }.resume()
  }
}
