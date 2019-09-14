import SwiftUI

struct Home: View {

  var store = DataStore()

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("by Diego Lavalle").italic()
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .padding(.horizontal)
        Posts()
        Spacer()
      }
      .navigationBarTitle("Swift You and I")
    }
    .environmentObject(store)
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
