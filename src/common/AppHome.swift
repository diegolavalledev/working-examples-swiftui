import SwiftUI

struct AppHome: View {

  enum Tabs: Hashable {
    case posts, examples
  }

  @State var tab = Tabs.posts

  var body: some View {
    TabView(selection: $tab) {
      PostsHome()
      .tag(Tabs.posts)
      .tabItem {
        Label("Swift You and I", systemImage: "newspaper.fill")
      }
      ExamplesHome()
      .tag(Tabs.examples)
      .tabItem {
        Label("Working Examples", systemImage: "hand.tap.fill")
      }
    }
    .onOpenURL { url in

      let pathComponents = url.pathComponents
      guard pathComponents.count == 3, pathComponents[1] == "examples" else {
        return
      }

      tab = .examples
    }
  }
}

struct AppHome_Previews: PreviewProvider {
  static var previews: some View {
    AppHome()
  }
}
