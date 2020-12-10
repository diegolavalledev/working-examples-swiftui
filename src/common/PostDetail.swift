import SwiftUI
import WorkingExamples
import Combine

struct PostDetail: View {
  let post: PostModel
  
  @State private var postTask: AnyCancellable?
  @State private var imageTask: AnyCancellable?

  @State var postDetails: PostModel?
  @State var coverImage: CGImage?

  var body: some View {
    ScrollView { VStack {

      HStack {
        Text("@\(post.params.twitter)")
        .font(.footnote)
        .italic()
        .foregroundColor(Color("secondaryLabel"))
        Spacer()
        Text("\(post.date, formatter: .postDate)")
        .font(.footnote)
        .foregroundColor(Color("secondaryLabel"))
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      .padding([.bottom, .horizontal])

      Text(post.title).font(.largeTitle)
      Text(post.subtitle).italic()

      if let coverImage = coverImage {
        Image(coverImage, scale: 1.0, label: Text("Cover Image"))
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
      }

      if let postDetails = postDetails {
        Text(postDetails.plainSummary).padding()
      } else {
        VStack {
          Text("Lorem ipsum")
          .redacted(reason: .placeholder)
          ProgressView()
        }
        .padding()
      }
      Link(destination: URL(string: post.permalink)!, label: {
        Text("Continue reading ") + Text(post.title).italic() + Text("…")
      })
      .padding(.horizontal)

      Spacer()
    } }
    .onAppear {
      postTask = post.detailsPublisher.assign(to: \.postDetails, on: self)
      imageTask = post.coverImage?.publisher.assign(to: \.coverImage, on: self)
    }
  }
}

struct PostDetail_Previews: PreviewProvider {
  static var previews: some View {
    PostDetail(post: .sample)
  }
}
