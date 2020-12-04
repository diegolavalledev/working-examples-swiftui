import SwiftUI
import WorkingExamples

struct ExampleList: View {

  let examples: [ExampleModel]
  @Binding var selectedExample: ExampleModel?

  var exampleDetail: some View {
    Group {
      if let example = selectedExample {
        ExampleDetail(example: example)
      }
    }
  }

  var body: some View {
    List {
      ForEach(examples) { example in
        NavigationLink(
          destination: exampleDetail,
          tag: example,
          selection: $selectedExample,
          label: {
            Text("\(example.title)")
          }
        )
      }
    }
  }
}

struct ExampleList_Previews: PreviewProvider {
  static var previews: some View {
    ExampleList(examples: [ExampleModel.sample], selectedExample: .constant(nil))
  }
}
