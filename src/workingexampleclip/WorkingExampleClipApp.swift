import SwiftUI
import WorkingExamples

@main
struct WorkingExampleClipApp: App {

  @StateObject var appData = AppData()
  @State var selectedExample = ExampleModel?.none
  @State var temporaryUrl = URL?.none

  var viewBody: some View {
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
  }

  var body: some Scene {
    WindowGroup {
      viewBody
      .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
        temporaryUrl = userActivity.webpageURL
        if temporaryUrl == .none { return }

        selectedExample = .none
        appData.reloadExamples()
      }
    }
    .onChange(of: appData.examples) { _ in
      guard
        let url = temporaryUrl,
        let examples = appData.examples
      else { return }

      temporaryUrl = nil
      selectedExample = examples.findByUrl(url) ?? examples.randomElement()
    }
    //.onChange(of: selectedExample) { _ in } // Work-around for onOpenURL/onContinueUserActivity bug
  }
}
