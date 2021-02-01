import SwiftUI
import WorkingExamples

struct ExamplesHome: View {

  @EnvironmentObject var appData: AppData
  @State var selectedExample = ExampleModel?.none
  @State var requestedUrl = URL?.none

  var body: some View {
    NavigationView {
      Group {
        if let examples = appData.examples {
          ExampleList(examples: examples, selectedExample: $selectedExample)
        } else {
          ProgressView("Loading examples…")
        }
      }
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Working Examples").font(.largeTitle)
        }
      }
      Text("Select an example from the side-bar to view its details.")
    }
    .onAppear {
      if appData.examples == nil {
        appData.reloadExamples()
      }
    }
    .onChange(of: selectedExample) { _ in } // Work-around for onOpenURL/onContinueUserActivity bug
    .onChange(of: appData.examples) { _ in

      guard let examples = appData.examples, let url = requestedUrl else {
        return
      }

      requestedUrl = nil
      guard let example = examples.findByUrl(url) else {
        return
      }

      selectedExample = example
    }
    .onOpenURL(perform: handle)
    .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) {
      if let url = $0.webpageURL { handle(url) }
    }
  }

  func handle(_ url: URL) {
    if let example = appData.examples?.findByUrl(url) {
      selectedExample = example
    } else {
      requestedUrl = url
    }
  }
}

struct ExamplesHome_Previews: PreviewProvider {
  static var previews: some View {
    ExamplesHome()
  }
}
