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
    ScrollView { VStack(alignment: .leading) {
      Text(example.title).font(.largeTitle).padding(.horizontal)
      Text(example.subtitle).italic().padding(.horizontal)

      if let exampleDetails = exampleDetails {
        Text(exampleDetails.plainSummary).padding()
      } else {
        VStack(alignment: .leading) {
          Text("Lorem ipsum")
          .redacted(reason: .placeholder)
          ProgressView()
        }
        .padding()
      }

      Divider()

      Button(action: {
        present.toggle()
      }) {
        VStack {
          if let iconImage = iconImage {
            Image(iconImage, scale: 1.0, label: Text("Example Image"))
          } else {
            Image(systemName: "questionmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipped()
            .redacted(reason: .placeholder)
          }
          Text("Run ") + Text(example.title).italic()
        }
        .buttonStyle(BorderlessButtonStyle())
        .frame(maxWidth: .infinity)
      }.padding()

      Spacer()
    } }
    .onAppear {
      exampleTask = example.detailsPublisher.assign(to: \.exampleDetails, on: self)
      imageTask = example.iconImage.publisher.assign(to: \.iconImage, on: self)
    }
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
