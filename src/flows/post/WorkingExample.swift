import SwiftUI
import SwiftUIWorkingExamples

struct WorkingExample: View, Identifiable {

  var id: String

  var body: some View {
    Group {
      if id == "/posts/no-uiimage/" {
        ImprovedPlaneMoonScene()
      } else if id == "/posts/combine-form-validation/" {
        SignUpForm()
      } else {
        Text("This post does yet not provide a working example.")
      }
    }
  }
}

struct WorkingExample_Previews: PreviewProvider {
  static var previews: some View {
    WorkingExample(id: "/posts/no-uiimage/")
  }
}
