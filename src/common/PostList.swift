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
    ScrollView(.vertical) {
      VStack(alignment: .leading) {
        ForEach(posts) { post in
          VStack(alignment: .leading) {
              Text("\(post.date, formatter: .postDate)")
              .font(.footnote)
              .foregroundColor(Color("secondaryLabel"))
              .frame(maxWidth: .infinity, alignment: .trailing)
              .padding(.bottom)

              Text("\(post.title)").font(.headline)
              Text("\(post.subtitle)").font(.subheadline).padding(.vertical)
              NavigationLink(
                destination: postDetail,
                tag: post,
                selection: $selectedPost,
                label: {
                  Text("Read More")
                  .frame(maxWidth: .infinity, alignment: .trailing)
                }
              )
              Divider()
          }.padding()
        }
        Spacer()
      }
    }
  }
}

struct PostList_Previews: PreviewProvider {
  static var previews: some View {
    PostList(posts: [PostModel.sample])
  }
}
