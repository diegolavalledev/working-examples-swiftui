import SwiftUI
import WorkingExamples

struct ExamplesHome: View {

  @EnvironmentObject var appData: AppData
  @State var selectedExample = ExampleModel?.none
  @State var temporaryName = String?.none

  var body: some View {
    NavigationView {
      Group {
        if let examples = appData.examples {
          ExampleList(examples: examples, selectedExample: $selectedExample)
        } else {
          ProgressView("Loading examples…")
        }
      }
      .navigationTitle("Working Examples")
      Text("Select an example from the side-bar to view its details.")
    }
    .onChange(of: appData.examples) { _ in
      guard let name = temporaryName else {
        return
      }
      temporaryName = nil
      guard let example = appData.examples?.findBySlug(name) else {
        return
      }
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
      let name = pathComponents[2]
      if let example = appData.examples?.findBySlug(name) {
        selectedExample = example
      } else {
        temporaryName = name
      }
    }
    .onOpenURL { url in
      let pathComponents = url.pathComponents
      guard pathComponents.count == 3 else {
        return
      }
      let name = pathComponents[2]
      if let example = appData.examples?.findBySlug(name) {
        selectedExample = example
      } else {
        temporaryName = name
      }
    }
  }
}

struct ExamplesHome_Previews: PreviewProvider {
  static var previews: some View {
    ExamplesHome()
  }
}
