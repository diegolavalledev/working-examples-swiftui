import SwiftUI
import SwiftUIWorkingExamples

struct Post: View {

  var post: PostModel
  @State var workingExample: WorkingExample?

  private var dateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "dd MMM YYYY"
    return df
  }

  var body: some View {
    VStack {
      Text("\(post.title)")
      .font(.title)
      Text("\(post.date, formatter: dateFormatter)")
      .font(.caption)
      Text("\(post.plainSummary)")
      .padding()
      HStack {
        Button("Read online") {
          UIApplication.shared.open(
            URL(string: self.post.permalink)!
          )
        }
        Button("Working Example") {
          self.workingExample = WorkingExample(id: self.post.relPermalink)
        }
        Button("Source Code") {
          UIApplication.shared.open(
            URL(string: "https://github.com/swift-you-and-i/working-examples/tree/master/Sources/WorkingExamples/combine-form-validation")!
          )
        }
      }
    }
    .sheet(item: $workingExample) {workingExample in
      workingExample
    }
  }
}

struct Post_Previews: PreviewProvider {
  static var previews: some View {
    Post(post: PostModel.specimen)
  }
}
