import SwiftUI
import WorkingExamples

@main
struct WorkingExampleClipApp: App {

  @StateObject var appData = AppData()
  @State var selectedExample = ExampleModel?.none
  @State var temporaryUrl = URL?.none

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

        guard let url = temporaryUrl, let examples = appData.examples, let example = examples.findByUrl(url) else {
          return
        }

        temporaryName = nil
        selectedExample = example
      }
      .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in

        guard let url = userActivity.webpageURL else {
          return
        }

        if let examples = appData.examples, let example = examples.findByUrl(url) {
          selectedExample = example
        } else {
          temporaryUrl = url
        }
      }
    }
  }
}
