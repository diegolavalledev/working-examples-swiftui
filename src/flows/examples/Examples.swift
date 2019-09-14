import SwiftUI

struct Examples: View {

  var posts: [PostModel]

  var body: some View {
    VStack {
      ForEach(posts) {
        ExampleSummary(post: $0)
      }
      Spacer()
    }
  }
}

struct Examples_Previews: PreviewProvider {
  static var previews: some View {
    Examples(posts: [PostModel.specimen, PostModel.specimen])
    .previewLayout(.sizeThatFits)
  }
}
