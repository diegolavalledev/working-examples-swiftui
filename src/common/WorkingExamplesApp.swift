import SwiftUI

@main
struct WorkingExamplesApp: App {
  @StateObject var appData = AppData()

  var body: some Scene {
    WindowGroup {
      AppHome()
      .environmentObject(appData)
      .accentColor(Color("AccentColor"))
    }

    #if os(macOS)
      Settings {
        SettingsView()
      }
    #endif
  }
}
