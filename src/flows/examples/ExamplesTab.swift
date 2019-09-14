import SwiftUI

struct ExamplesTab: View {

  @State var examples: [ExampleModel]!
  @EnvironmentObject private var store: DataStore

  var body: some View {
    NavigationView {
      Group {
        if examples == nil {
          Text("Loading examples…")
        } else {
          ScrollView(.vertical) {
            Examples(examples: examples)
          }
        }
      }
      .navigationBarTitle("Live examples")
      VStack {
        Text("Examples")
        .font(.headline)
        Text("Swipe from the left edge of the device to reveal the examples list")
      }
      .padding()
    }
    .onAppear {
      self.store.examplesRequest.send("")
    }
    .onReceive(store.examples) {
      self.examples = $0
    }
  }
}

struct ExamplesTab_Previews: PreviewProvider {
  static var previews: some View {
    ExamplesTab()
  }
}
