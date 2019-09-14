import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var appConfig = AppConfiguration()

  enum ResourceType: String {
    case post = "posts"
    case example = "examples"
  }

  func parseUrl(url: URL) {
    let pathComponents = url.pathComponents

    guard pathComponents.count > 2 else {
      // Wrong format
      return
    }

    let resourceTypeString = pathComponents.dropLast().last!
    let resourceSlug = pathComponents.last!

    guard let resourceType = ResourceType.init(rawValue: resourceTypeString) else {
      // Unknown resource type
      return
    }

    switch resourceType {
      case .post:
        appConfig.tab = .posts
        appConfig.postSlug = resourceSlug
      case .example:
        appConfig.tab = .examples
        appConfig.exampleSlug = resourceSlug
    }
  }

  func scene(_ scene: UIScene,
  continue userActivity: NSUserActivity) {
    guard
      userActivity.activityType == NSUserActivityTypeBrowsingWeb
    else {
      return
    }
    parseUrl(url: userActivity.webpageURL!)
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else {
      return
    }

    if let userActivity = connectionOptions.userActivities.first(where: { $0.activityType == NSUserActivityTypeBrowsingWeb }) {
      parseUrl(url: userActivity.webpageURL!)
    }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: Home().environmentObject(appConfig))
    self.window = window
    window.makeKeyAndVisible()
  }
}
