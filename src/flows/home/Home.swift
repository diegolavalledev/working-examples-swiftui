import SwiftUI

struct Home: View {

  @EnvironmentObject var appConfig: AppConfiguration
  var store = DataStore()

  var body: some View {
    TabView(selection: $appConfig.tab) {
      PostsTab()
      .tag(AppConfiguration.Tab.posts)
      .tabItem {
        Image(systemName: "square.stack.fill")
        Text("Posts")
      }
      ExamplesTab()
      .tag(AppConfiguration.Tab.examples)
      .tabItem {
        Image(systemName: "hand.draw.fill")
        Text("Examples")
      }
      FavoritesTab()
      .tag(AppConfiguration.Tab.favorites)
      .tabItem {
        Image(systemName: "heart.fill")
        Text("Favorites")
      }
      SearchTab()
      .tag(AppConfiguration.Tab.search)
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
    .environmentObject(AppConfiguration())
  }
}
