import SwiftUI
import WorkingExamples
import Combine

struct ExampleDetail: View {
  let example: ExampleModel
  
  @State var present = false

  @State private var exampleTask: AnyCancellable?
  @State private var imageTask: AnyCancellable?

  @State var exampleDetails: ExampleModel?
  @State var iconImage: CGImage?

  var body: some View {
    VStack {
      Text(example.title).font(.headline)
      Text(example.subtitle).font(.subheadline)

      if let exampleDetails = exampleDetails {
        Text(exampleDetails.subtitle)
      } else {
        ProgressView()
      }
      if let iconImage = iconImage {
        Image(iconImage, scale: 1.0, label: Text("Example Image"))
      } else {
        Image(systemName: "questionmark")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
        .clipped()
      }
      Button("Run Working Example") {
        present.toggle()
      }
    }
    .onAppear {
      exampleTask = example.detailsPublisher.assign(to: \.exampleDetails, on: self)
      imageTask = example.iconImage.publisher.assign(to: \.iconImage, on: self)
    }
    .navigationTitle(example.title)
    .sheet(isPresented: $present) {
      example.view
    }
  }
}

struct ExampleDetail_Previews: PreviewProvider {
  static var previews: some View {
    ExampleDetail(example: .sample)
  }
}
