import SwiftUI
import WorkingExamples
import Combine

struct PostDetail: View {
  let post: PostModel
  
  @State private var postTask: AnyCancellable?
  @State private var imageTask: AnyCancellable?

  @State var postDetails: PostModel?
  @State var iconImage: CGImage?

  var body: some View {
    VStack {
      Text(post.title).font(.headline)

      if let postDetails = postDetails {
        Text(postDetails.title)
      } else {
        ProgressView()
      }
      if let featureImageMetadata = post.featureImage {
        if let iconImage = iconImage {
          Image(iconImage, scale: 1.0, label: Text("Post Image"))
        } else {
          Image(systemName: "questionmark")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: featureImageMetadata.width, height: featureImageMetadata.height)
          .clipped()
        }
      }
    }
    .onAppear {
      postTask = post.detailsPublisher.assign(to: \.postDetails, on: self)
      imageTask = post.featureImage?.publisher.assign(to: \.iconImage, on: self)
      if post.featureImage == nil {
        print("featureImage nil")
      } else {
        print("featureImage not nil")
      
      }
    }
    .navigationTitle(post.title)
  }
}

struct PostDetail_Previews: PreviewProvider {
  static var previews: some View {
    PostDetail(post: .sample)
  }
}
