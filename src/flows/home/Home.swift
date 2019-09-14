import SwiftUI

struct Home: View {

  var store = DataStore()

  var body: some View {
    TabView {
      PostsTab()
      .tabItem {
        Image(systemName: "square.stack.fill")
        Text("Posts")
      }
      ExamplesTab()
      .tabItem {
        Image(systemName: "hand.draw.fill")
        Text("Examples")
      }
      FavoritesTab()
      .tabItem {
        Image(systemName: "heart.fill")
        Text("Favorites")
      }
      SearchTab()
      .tabItem {
        Image(systemName: "magnifyingglass")
        Text("Search")
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
