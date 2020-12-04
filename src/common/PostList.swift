import SwiftUI

struct PostList: View {

  let posts: [PostModel]
  @State var selectedPost: PostModel?

  var postDetail: some View {
    Group {
      if let post = selectedPost {
        PostDetail(post: post)
      }
    }
  }

  var body: some View {
    List {
      ForEach(posts) { post in
        NavigationLink(
          destination: postDetail,
          tag: post,
          selection: $selectedPost,
          label: {
            Text("\(post.title)")
          }
        )
      }
    }
  }
}

struct PostList_Previews: PreviewProvider {
  static var previews: some View {
    PostList(posts: [PostModel.sample])
  }
}
