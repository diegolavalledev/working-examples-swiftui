import SwiftUI
import WorkingExamples

extension ExampleModel {
  var view: Example? {
    if let example = Example(self.slug) {
      return example
    }
    return nil
  }
}
