import SwiftUI
import WorkingExamples
import Combine

struct PostsHome: View {

  @State var posts = [PostModel]?.none
  @State private var postsTask: AnyCancellable?

  var body: some View {
    NavigationView {
      Group {
        if let posts = posts {
          PostList(posts: posts)
        } else {
          ProgressView("Loading articles…")
        }
      }
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Latest Articles").font(.largeTitle)
        }
      }
      Text("Select an article from the side-bar to view its details.")
    }
    .onAppear {
      postsTask = PostModel.postsPublisher.assign(to: \.posts, on: self)
    }
  }
}

struct PostsHome_Previews: PreviewProvider {
  static var previews: some View {
    PostsHome()
  }
}
