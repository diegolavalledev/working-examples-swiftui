import SwiftUI

struct ExamplesTab: View {

  var body: some View {
    NavigationView {
      Text("Examples")
      .navigationBarTitle("Examples")
    }
  }
}

struct ExamplesTab_Previews: PreviewProvider {
  static var previews: some View {
    ExamplesTab()
  }
}
