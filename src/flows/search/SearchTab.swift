import SwiftUI

struct SearchTab: View {

  @State var posts: [PostModel]?
  @EnvironmentObject private var store: DataStore

  var tags: [String] {
    Array(Set(
      posts!
      .reduce(into: []) {
        $0.append($1.params.tags)
      }
      .flatMap { $0 }
    ))
  }

  var body: some View {
    NavigationView {
      Group {
        if posts == nil {
          Text("Loading tags…")
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              Spacer()
              ForEach(tags, id: \.self) { tag in
                NavigationLink("\(tag)", destination:
                  ScrollView(.vertical) {
                    Posts(byTag: tag, posts: self.posts!)
                    .navigationBarTitle("\(tag)")
                  }
                )
                .padding()
              }
              Spacer()
            }
          }
        }
      }
      .navigationBarTitle("Available tags")
      //.navigationBarHidden(true)
    }
    .onAppear {
      self.store.postsRequest.send("")
    }
    .onReceive(store.posts) {
      self.posts = $0
    }
  }
}

struct SearchTab_Previews: PreviewProvider {
  static var previews: some View {
    SearchTab()
  }
}
