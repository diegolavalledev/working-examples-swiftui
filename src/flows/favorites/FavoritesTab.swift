import SwiftUI

struct FavoritesTab: View {

  var body: some View {
    NavigationView {
      Text("Favorites")
      .navigationBarTitle("Favorites")
    }
  }
}

struct FavoritesTab_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesTab()
  }
}
