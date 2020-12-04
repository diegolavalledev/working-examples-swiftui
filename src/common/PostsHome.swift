import SwiftUI
import WorkingExamples

struct PostsHome: View {

  @EnvironmentObject var appData: AppData

  var body: some View {
    NavigationView {
      Group {
        if let posts = appData.posts {
          PostList(posts: posts)
        } else {
          ProgressView("Loading articles…")
        }
      }
      .navigationTitle("Latest Articles")
      Text("Select an article from the side-bar to view its details.")
    }
  }
}

struct PostsHome_Previews: PreviewProvider {
  static var previews: some View {
    PostsHome()
  }
}
