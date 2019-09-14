import SwiftUI

struct Posts: View {

  @State var posts: [PostModel]?
  @EnvironmentObject private var store: DataStore

  var body: some View {
    Group {
      if posts == nil {
        Text("Loading posts")
      } else {
        ScrollView(.vertical) {
          VStack {
            ForEach(posts!) {
              PostSummary(post: $0)
            }
          }
        }
      }
    }
    .onAppear {
      self.store.postsRequest.send("")
      // TODO: send the actual request enum
    }
    .onReceive(store.posts) {
      self.posts = $0
    }
  }
}

struct Posts_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Posts()
      Posts(posts: [PostModel.specimen, PostModel.specimen])
    }
    .environmentObject(DataStore())
    .previewLayout(.sizeThatFits)
  }
}
