import SwiftUI

struct FeaturedPost: View {

  @State var maybePost: PostModel?
  @EnvironmentObject private var store: DataStore

  var featuredPost: PostModel {
    maybePost!
  }
  
  var body: some View {
    Group {
      if maybePost == nil {
        Text("Loading post")
      } else {
        ScrollView(.vertical) {
          VStack {
            FeatureImage(post: featuredPost)
            Post(post: featuredPost)
          }
        }
      }
    }
    .onAppear {
      self.store.postsRequest.send("")
      // TODO: send the actual request enum
    }
    .onReceive(store.posts) {
      self.maybePost = $0.first { $0.params.featured }
    }
  }
}

struct FeaturedPost_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FeaturedPost()
      FeaturedPost(maybePost: PostModel.specimen)
    }
    .environmentObject(DataStore())
    .previewLayout(.sizeThatFits)
  }
}
