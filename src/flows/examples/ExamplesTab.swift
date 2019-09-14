import SwiftUI

struct ExamplesTab: View {

  @State var posts: [PostModel]?
  @EnvironmentObject private var store: DataStore

  var examplePosts: [PostModel] {
    posts!.filter { $0.params.hasDemo }
  }

  var body: some View {
    NavigationView {
      Group {
        if posts == nil {
          Text("Loading posts…")
        } else {
          ScrollView(.vertical) {
            Examples(posts: examplePosts)
          }
        }
      }
      .navigationBarTitle("Live examples")
    }
    .onAppear {
      self.store.postsRequest.send("")
    }
    .onReceive(store.posts) {
      self.posts = $0
    }
  }
}

struct ExamplesTab_Previews: PreviewProvider {
  static var previews: some View {
    ExamplesTab()
  }
}
