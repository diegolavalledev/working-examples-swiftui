import SwiftUI

struct SearchTab: View {

  var body: some View {
    NavigationView {
      Text("Search")
      .navigationBarTitle("")
      .navigationBarHidden(true)
    }
  }
}

struct SearchTab_Previews: PreviewProvider {
  static var previews: some View {
    SearchTab()
  }
}
