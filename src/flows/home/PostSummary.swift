import SwiftUI

struct PostSummary: View {

  var post: PostModel

  private var dateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "dd MMMM YYYY"
    return df
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("\(post.title)")
        .font(.title)
        .fixedSize(horizontal: false, vertical: true)
        .layoutPriority(-1)
        Spacer()
        Text("\(post.date, formatter: dateFormatter)")
        .font(.caption)
      }
      Text("\(post.plainSummary)")
      .lineLimit(1)
      //.padding()
      NavigationLink("See post", destination: Post(post: post))
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
    .padding()
  }
}

struct PostSummary_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      PostSummary(post: PostModel.specimen)
      .background(Color("background"))
      .environment(\.colorScheme, .dark)
      PostSummary(post: PostModel.specimen)

    }
    .previewLayout(.sizeThatFits)
  }
}
