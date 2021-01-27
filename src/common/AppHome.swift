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
    .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
      guard let url = userActivity.webpageURL else {
        return
      }
      let pathComponents = url.pathComponents
      guard pathComponents.count == 3 else {
        return
      }
      let section = pathComponents[1]
      if section == "examples" {
        tab = .examples
      }
    }
    .onOpenURL { url in
      let pathComponents = url.pathComponents
      guard pathComponents.count == 3 else {
        return
      }
      let section = pathComponents[1]
      if section == "examples" {
        tab = .examples
      }
    }
  }
}

struct AppHome_Previews: PreviewProvider {
  static var previews: some View {
    AppHome()
  }
}
