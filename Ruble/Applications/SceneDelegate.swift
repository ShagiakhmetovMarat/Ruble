//
//  SceneDelegate.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 04.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = createTabBar()
    }
    
    private func createTabBar() -> UITabBarController {
        let rubleVC = RubleViewController()
        let settingNC = UINavigationController(rootViewController: SettingViewController())
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            setupVC(viewController: rubleVC,
                    title: "Ruble",
                    image: UIImage(systemName: "rublesign")),
            setupVC(viewController: settingNC,
                    title: "Settings",
                    image: UIImage(systemName: "gear"))
        ]
        tabBar.tabBar.tintColor = .darkGreen
        tabBar.tabBar.backgroundColor = .white
        
        return tabBar
    }
    
    private func setupVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBarAppearence(tabBar: UITabBarController) -> UITabBarController {
        let positionX: CGFloat = 10
        let positionY: CGFloat = 18
        let width = tabBar.tabBar.bounds.width - positionX * 8
        let height = tabBar.tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect:
                CGRect(x: positionX * 4,
                       y: tabBar.tabBar.bounds.minY - positionY,
                       width: width,
                       height: height),
            cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.tabBar.itemWidth = width / 3.5
        tabBar.tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.darkGreen.cgColor
        
        tabBar.tabBar.tintColor = UIColor.white
        tabBar.tabBar.unselectedItemTintColor = UIColor.beige
        
        return tabBar
    }
}

