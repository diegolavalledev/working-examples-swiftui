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

  @EnvironmentObject private var store: DataStore

  @State var isFavorite = false

  var isReallyFavorite: Bool {
    store.favorites.contains(post.slug)
  }

  func toggleFavorite() -> () {
    isFavorite.toggle()
    if !isFavorite && isReallyFavorite {
      store.favorites.removeAll { $0 == post.slug }
    } else if isFavorite && !isReallyFavorite {
      store.favorites.insert(post.slug, at: 0)
    }
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack(alignment: .leading) {
        Text("\(post.date, formatter: dateFormatter)")
        .font(.footnote)
        .foregroundColor(Color("secondaryLabel"))

        Text("\(post.title)")
        .font(.title)

        HStack {
          Spacer()
          Image(systemName: "ellipsis.circle.fill")
          .foregroundColor(.accentColor)
        }
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
          
          if post.params.hasDemo {
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

          Button(action: toggleFavorite) {
            HStack {
              if isFavorite {
                Text("Remove from Favorites")
              } else {
                Text("Add to Favorites")
              }
              Spacer()
              Image(systemName: isFavorite ? "heart.slash" : "heart" )
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
    .onAppear {
      self.isFavorite = self.isReallyFavorite
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
