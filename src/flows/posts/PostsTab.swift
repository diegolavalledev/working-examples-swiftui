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
              Divider()
            }
            Text("All posts")
            .font(.title)
            Posts(posts: posts!)
          }
          Spacer()
        }
        .frame(maxWidth: .infinity)
      }
      .navigationBarTitle("Featured Post")
      VStack {
        Text("Posts")
        .font(.headline)
        Text("Swipe from the left edge of the device to reveal the posts list")
      }
      .padding()
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
