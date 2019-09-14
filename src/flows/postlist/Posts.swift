import SwiftUI

struct Posts: View {

  var byTag: String?
  var posts: [PostModel]
  @EnvironmentObject var appConfig: AppConfiguration

  var filteredPosts: [PostModel] {
    guard let tag = byTag else {
      return posts
    }
    return posts.filter { $0.params.tags.contains(tag) }
  }

  var body: some View {
    VStack {
      ForEach(filteredPosts) {
        NavigationLink(destination: Post(post: $0), tag: $0.slug, selection: self.$appConfig.postSlug) {
          EmptyView()
        }
        PostSummary(post: $0)
      }
      Spacer()
    }
  }
}

struct Posts_Previews: PreviewProvider {
  static var previews: some View {
    Posts(posts: [PostModel.specimen, PostModel.specimen])
    .previewLayout(.sizeThatFits)
    .environmentObject(AppConfiguration())
  }
}
