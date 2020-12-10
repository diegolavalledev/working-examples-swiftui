import SwiftUI
import WorkingExamples

@main
struct WorkingExampleClipApp: App {

  @StateObject var appData = AppData()
  @State var selectedExample = ExampleModel?.none
  @State var temporaryName = String?.none

  var body: some Scene {
    WindowGroup {
      Group {
        if let example = selectedExample {
          NavigationView {
            ExampleDetail(example: example, present: true)
          }
          .navigationViewStyle(StackNavigationViewStyle())
        } else {
          ProgressView("Loading example…")
        }
      }
      .onChange(of: appData.examples) { _ in
        guard
          let name = temporaryName,
          let examples = appData.examples,
          let example = examples.first(where: { $0.slug == name })
        else {
          return
        }
        temporaryName = nil
        selectedExample = example
      }
      .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
        guard let url = userActivity.webpageURL else {
          return
        }
        let pathComponents = url.pathComponents
        guard pathComponents.count == 3 else {
          return
        }
        temporaryName = pathComponents[2]
      }
    }
  }
}
