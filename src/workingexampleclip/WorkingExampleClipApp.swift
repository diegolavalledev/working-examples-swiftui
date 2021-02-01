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
            .id(example) // Work-around for bug by which the example details don't completely reload
          }
          .navigationViewStyle(StackNavigationViewStyle())
        } else {
          ProgressView("Loading example…")
        }
      }
      .onChange(of: appData.examples) { _ in

        guard
          let url = temporaryUrl,
          let examples = appData.examples,
          let example = examples.findByUrl(url)
        else { return }
        
        temporaryUrl = nil
        selectedExample = example
      }
      .onChange(of: selectedExample) { _ in } // Work-around for onOpenURL/onContinueUserActivity bug
      .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in

        temporaryUrl = userActivity.webpageURL
        if temporaryUrl == .none { return }

        selectedExample = .none
        appData.reloadExamples()
      }
    }
  }
}
