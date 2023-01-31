import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  // MARK: UIWindowSceneDelegate
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let viewController = DashboardViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
   (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
}

