import SwiftUI

struct FeatureImage: View {

  var imageResource: Resource
  var coordinator: Resource.Coordinator

  @State private var image: Image?

  init(imageResource: Resource) {
    self.imageResource = imageResource
    self.coordinator = imageResource.coordinator
  }

  var body: some View {
    Group {
      if image == nil {
        Image(systemName: "paperclip")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .aspectRatio(contentMode: .fit)
        .frame(width: 150)
      } else {
        image!
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 150)
      }
    }
    .onAppear {
      //self.imageResource.requestImage()
      self.coordinator.requests.send("")
    }
    .onReceive(self.coordinator.responses) {
      self.image = $0
    }
  }
}

struct FeatureImage_Previews: PreviewProvider {
  static var previews: some View {
    FeatureImage(imageResource: Resource.specimen)
  }
}
