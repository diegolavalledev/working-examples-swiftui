import SwiftUI

struct FeatureImage: View {

  var post: PostModel
  @State var image: Image?

  var postImageManager: PostImageManager {
    PostImageManager(post)
  }

  var body: some View {
    Group {
      if image == nil {
        Image(systemName: "paperclip")
      } else {
        image!
        .resizable()
        .frame(width: 200)
        .aspectRatio(contentMode: .fit)
      }
    }
    .onAppear {
      self.postImageManager.imageRequest.send("feature")
    }
    .onReceive(postImageManager.imageResponse) {
      self.image = $0
    }
  }
}

struct FeatureImage_Previews: PreviewProvider {
  static var previews: some View {
    FeatureImage(post: PostModel.specimen)
  }
}
