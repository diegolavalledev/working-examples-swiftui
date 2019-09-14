import SwiftUI

struct FeaturedPost: View {

  var post: PostModel

  var body: some View {
    VStack {
      FeatureImage(imageResource: post.featureImage)
      PostSummary(post: post)
    }
  }
}

struct FeaturedPost_Previews: PreviewProvider {
  static var previews: some View {
    FeaturedPost(post: PostModel.specimen)
    .previewLayout(.sizeThatFits)
  }
}
