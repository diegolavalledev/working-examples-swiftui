import SwiftUI

struct AppHome: View {

  @State var tab = 0
  var body: some View {
    TabView(selection: $tab) {
      PostsHome()
      .tag(0)
      .tabItem {
        Image(systemName: "newspaper.fill")
        Text("Swift You and I")
      }
      ExamplesHome()
      .tag(1)
      .tabItem {
        Image(systemName: "hand.tap.fill")
        Text("Working Examples")
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
        tab = 1
      }
    }
    .onOpenURL { url in
      let pathComponents = url.pathComponents
      guard pathComponents.count == 3 else {
        return
      }
      let section = pathComponents[1]
      if section == "examples" {
        tab = 1
      }
    }
  }
}

struct AppHome_Previews: PreviewProvider {
  static var previews: some View {
    AppHome()
  }
}
