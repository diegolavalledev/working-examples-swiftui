import SwiftUI

struct AppHome: View {

  enum Tabs: Hashable {
    case posts, examples
  }

  @State var tab = Tabs.posts
  @State var requestedUrl = URL?.none

  var body: some View {
    TabView(selection: $tab) {
      PostsHome()
      .tag(Tabs.posts)
      .tabItem {
        Label("Swift You and I", systemImage: "newspaper.fill")
      }
      ExamplesHome(requestedUrl: requestedUrl)
      .tag(Tabs.examples)
      .tabItem {
        Label("Working Examples", systemImage: "hand.tap.fill")
      }
    }
    .onOpenURL(perform: handle)
    .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) {
      if let url = $0.webpageURL {
          handle(url)
      }
    }
  }

  func handle(_ url: URL) {
    let pathComponents = url.pathComponents
    guard pathComponents.count == 3, pathComponents[1] == "examples" else {
      return
    }

    requestedUrl = url
    tab = .examples
  }
}

struct AppHome_Previews: PreviewProvider {
  static var previews: some View {
    AppHome()
  }
}
