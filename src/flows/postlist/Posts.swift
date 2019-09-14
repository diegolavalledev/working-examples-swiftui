import SwiftUI

struct Posts: View {

  var posts: [PostModel]

  var body: some View {
    VStack {
      ForEach(posts) {
        PostSummary(post: $0)
      }
    }
  }
}

struct Posts_Previews: PreviewProvider {
  static var previews: some View {
    Posts(posts: [PostModel.specimen, PostModel.specimen])
    .previewLayout(.sizeThatFits)
  }
}
