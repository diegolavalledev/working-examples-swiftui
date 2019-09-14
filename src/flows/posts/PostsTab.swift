import SwiftUI

struct PostsTab: View {

  @State var posts: [PostModel]?
  @EnvironmentObject private var store: DataStore

  var featuredPost: PostModel? {
    posts!.first { $0.params.featured }
  }

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        VStack {
          if posts == nil {
            Text("Downloading data…")
          } else {
            if featuredPost != nil {
              FeaturedPost(post: featuredPost!)
            }
            Color.gray.frame(height: 1).padding(.vertical)
            Posts(posts: posts!)
          }
          Spacer()
        }
        .frame(maxWidth: .infinity)
      }
      .navigationBarTitle("Swift You and I")
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

struct PostsTab_Previews: PreviewProvider {
  static var previews: some View {
    PostsTab()
  }
}
