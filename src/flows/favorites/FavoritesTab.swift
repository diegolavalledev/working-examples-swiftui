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
      VStack {
        Text("Favorites")
        .font(.headline)
        Text("Swipe from the left edge of the device to reveal the favorites list")
      }
      .padding()
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
