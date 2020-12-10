import Foundation

extension Formatter {
  static var postDate: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "dd MMM YYYY"
    return df
  }
}
