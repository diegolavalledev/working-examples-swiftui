import SwiftUI

struct PostsTab: View {

  var store = DataStore()

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Posts()
        Spacer()
      }
      .navigationBarTitle("Swift You and I")
    }
    .environmentObject(store)
  }
}

struct PostsTab_Previews: PreviewProvider {
  static var previews: some View {
    PostsTab()
  }
}
