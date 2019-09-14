import SwiftUI
import SwiftUIWorkingExamples

struct Post: View {

  var post: PostModel
  @State var showSheet = false
  @State var share = false

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
          self.share = false
          self.showSheet.toggle()
        }
        Button("Source Code") {
          UIApplication.shared.open(
            URL(string: "https://github.com/swift-you-and-i/working-examples/tree/master/Sources/WorkingExamples/combine-form-validation")!
          )
        }
      }
      Button(action: {
        self.share = true
        self.showSheet.toggle()
      }) {
        Image(systemName: "square.and.arrow.up")
        Text("Share")
      }
    }
    .sheet(isPresented: $showSheet) {
      if self.share {
        ShareSheet(activityItems: [
          URL(string: self.post.permalink)!,
          Image(systemName: "paperclip"),
          self.post.title
        ])
      } else {
        WorkingExample(id: self.post.slug)
      }
    }
  }
}

struct Post_Previews: PreviewProvider {
  static var previews: some View {
    Post(post: PostModel.specimen)
  }
}
