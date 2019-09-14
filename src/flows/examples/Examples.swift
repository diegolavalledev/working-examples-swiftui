import SwiftUI

struct Examples: View {

  var examples: [ExampleModel]

  var body: some View {
    VStack {
      ForEach(examples) {
        ExampleSummary(example: $0)
      }
      Spacer()
    }
  }
}

struct Examples_Previews: PreviewProvider {
  static var previews: some View {
    Examples(examples: [ExampleModel.specimen, ExampleModel.specimen])
    .previewLayout(.sizeThatFits)
  }
}
