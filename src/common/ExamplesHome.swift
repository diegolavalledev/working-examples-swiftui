import SwiftUI
import WorkingExamples

struct ExamplesHome: View {

  @EnvironmentObject var appData: AppData
  @State var selectedExample = ExampleModel?.none
  @State var temporaryUrl = URL?.none

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
      appData.reloadExamples()
    }
    .onChange(of: appData.examples) { _ in
      guard let url = temporaryUrl else {
        return
      }

      temporaryUrl = nil
      guard let example = appData.examples?.findByUrl(url) else {
        return
      }

      selectedExample = example
    }
    .onOpenURL { url in
      if let example = appData.examples?.findByUrl(url) {
        selectedExample = example
      } else {
        temporaryUrl = url
      }
    }
  }
}

struct ExamplesHome_Previews: PreviewProvider {
  static var previews: some View {
    ExamplesHome()
  }
}
