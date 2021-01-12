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
          let examples = appData.examples
        else {
          return
        }

        if name == "latest", let example = examples.first {
          temporaryName = nil
          selectedExample = example
        } else if let example = examples.first(where: { $0.slug == name }) {
          temporaryName = nil
          selectedExample = example
        } else {
          return
        }
      }
      .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
        guard let url = userActivity.webpageURL else {
          return
        }
        let pathComponents = url.pathComponents
        guard pathComponents.count > 1 else {
          return
        }
        let name = pathComponents.count > 2 ? pathComponents[2] : pathComponents[1]
        if let examples = appData.examples {
          if name == "latest", let example = examples.first {
            selectedExample = example
          } else if let example = examples.first(where: { $0.slug == name }) {
            selectedExample = example
          } else {
            temporaryName = name
          }
        } else {
          temporaryName = name
        }
      }
    }
  }
}
