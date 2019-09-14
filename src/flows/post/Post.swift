import SwiftUI
import SwiftUIWorkingExamples

struct Post: View {

  var post: PostModel
  @State var showSheet = false
  @State var showActionSheet = false
  @State var share = false

  private var dateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "dd MMM YYYY"
    return df
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack {
        Text("\(post.date, formatter: dateFormatter)")
        .font(.caption)
        Text("\(post.title)")
        .font(.title)
        Image(systemName: "ellipsis.circle.fill")
        .onTapGesture {
          self.showActionSheet.toggle()
        }
        Text("\(post.plainSummary)")
        VStack {
          Button(action: {
            UIApplication.shared.open(
              URL(string: self.post.permalink)!
            )
          }) {
            HStack {
              Text("Read online")
              Spacer()
              Image(systemName: "safari")
              // Image(systemName: "book")
            }
            .padding()
          }
          Button(action: {
            self.share = false
            self.showSheet.toggle()
          }) {
            HStack {
              Text("Live example")
              Spacer()
              Image(systemName: "hand.draw")
            }
            .padding()
          }
          Button(action: {
            UIApplication.shared.open(
              URL(string: "https://github.com/swift-you-and-i/working-examples/tree/master/Sources/WorkingExamples/")!
            )
          }) {
            HStack {
              Text("Source code")
              Spacer()
              Image(systemName: "chevron.left.slash.chevron.right")
            }
            .padding()
          }

          Button(action: {
            // TODO: Add to favorites
          }) {
            HStack {
              Text("Add to Favorites")
              Spacer()
              Image(systemName: "heart")
            }
            .padding()
          }

          Button(action: {
            self.share = true
            self.showSheet.toggle()
          }) {
            HStack {
              Text("Share")
              Spacer()
              Image(systemName: "square.and.arrow.up")
            }
            .padding()
          }
        }
        Spacer()
      }
      .padding()
    }
    .actionSheet(isPresented: $showActionSheet) {
      ActionSheet(
        title: Text("\(post.title)"),
        buttons: [
          .default(Text("Read online")) {
            UIApplication.shared.open(
              URL(string: self.post.permalink)!
            )
          },
          .cancel()
        ]
      )
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
