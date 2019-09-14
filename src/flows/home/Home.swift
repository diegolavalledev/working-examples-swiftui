import SwiftUI

struct Home: View {

  var store = DataStore()

  var body: some View {
    TabView {
      HomeTab()
      .tabItem {
        Image(systemName: "star")
        Text("Featured")
      }
      PostsTab()
      .tabItem {
        Image(systemName: "square.stack.fill")
        Text("Posts")
      }
    }
    .environmentObject(store)
    .accentColor(Color("accent"))
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Home()
      Home()
      .environment(\.colorScheme, .dark)
    }
  }
}
