import SwiftUI

struct FavoritePosts: View {

  var allPosts: [PostModel]
  @EnvironmentObject private var store: DataStore

  var favoritePosts: [PostModel] {
    allPosts.filter { store.favorites.contains($0.slug)  }
  }

  var body: some View {
    Posts(posts: favoritePosts)
  }
}

struct FavoritePosts_Previews: PreviewProvider {
  static var previews: some View {
    FavoritePosts(allPosts: [PostModel.specimen, PostModel.specimen])
    .previewLayout(.sizeThatFits)
  }
}
