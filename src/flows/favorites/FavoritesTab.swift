import SwiftUI

struct FavoritesTab: View {

  @State var posts: [PostModel]?
  @EnvironmentObject private var store: DataStore

  var body: some View {
    NavigationView {
      Group {
        if posts == nil {
          Text("Loading posts…")
        } else {
          ScrollView(.vertical) {
            FavoritePosts(allPosts: posts!)
          }
        }
      }
      .navigationBarTitle("Favorite posts")
    }
    .onAppear {
      self.store.postsRequest.send("")
    }
    .onReceive(store.posts) {
      self.posts = $0
    }
  }
}

struct FavoritesTab_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesTab()
  }
}
