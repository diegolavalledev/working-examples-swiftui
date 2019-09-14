import SwiftUI
import SwiftUIWorkingExamples

struct WorkingExample: View, Identifiable {

  var id: String

  var body: some View {
    Group {
      if id == "no-uiimage" {
        EmptyView()
      } else if id == "combine-form-validation" {
        SignUpForm()
      } else if id == "animation-ended" {
        ImprovedPlaneMoonScene()
      } else if id == "scroll-magic" {
        JumpingTitleBar()
      } else {
        Text("This post does yet not provide a working example.")
      }
    }
  }
}

struct WorkingExample_Previews: PreviewProvider {
  static var previews: some View {
    WorkingExample(id: "no-uiimage")
  }
}
