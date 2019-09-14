import SwiftUI
import SwiftUIWorkingExamples

struct ExampleSummary: View {

  var example: ExampleModel
  @State var showSheet = false
  @State var showActionSheet = false
  @State var share = false

  private var dateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "dd MMM YYYY"
    return df
  }

  var body: some View {
    VStack(alignment: .leading) {
      Text("\(example.date, formatter: dateFormatter)")
      .font(.footnote)
      .foregroundColor(Color("secondaryLabel"))

      Text("\(example.title)")
      .font(.title)
      Text("\(example.plainSummary)")
      .lineLimit(1)
      HStack {
        Spacer()
        Image(systemName: "hand.draw")
        .foregroundColor(.accentColor)
        Image(systemName: "ellipsis.circle.fill")
        .foregroundColor(.accentColor)
        .padding(.horizontal)
        .onTapGesture {
          self.showActionSheet.toggle()
        }
      }
    }
    .padding()
    .onTapGesture {
      self.share = false
      self.showSheet.toggle()
    }
    .actionSheet(isPresented: $showActionSheet) {
      ActionSheet(
        title: Text("\(example.title)"),
        buttons: [
          .default(Text("Live example")) {
            self.share = false
            self.showSheet.toggle()
          },
          .default(Text("Source code")) {
            UIApplication.shared.open(
              URL(string: "https://github.com/swift-you-and-i/working-examples/tree/master/Sources/WorkingExamples/")!
            )
          },
          .default(Text("Read post")) {
            UIApplication.shared.open(
              URL(string: self.example.permalink)!
            )
          },
          .default(Text("Share")) {
            self.share = true
            self.showSheet.toggle()
          },
          .cancel()
        ]
      )
    }
    .sheet(isPresented: $showSheet) {
      if self.share {
        ShareSheet(activityItems: [
          URL(string: self.example.permalink)!,
          Image(systemName: "paperclip"),
          self.example.title
        ])
      } else {
        WorkingExample(id: self.example.slug)
      }
    }
  }
}

struct ExampleSummary_Previews: PreviewProvider {
  static var previews: some View {
    ExampleSummary(example: ExampleModel.specimen)
  }
}
