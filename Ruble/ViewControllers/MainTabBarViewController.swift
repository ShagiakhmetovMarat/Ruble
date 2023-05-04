//
//  MainTabBarViewController.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 04.05.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarAppearence()
    }
    
    private func setupTabBar() {
        viewControllers = [
        setupVC(viewController: RubleViewController(),
                title: "Ruble",
                image: UIImage(systemName: "rublesign")),
        setupVC(viewController: SettingViewController(),
                title: "Setting",
                image: UIImage(systemName: "gear"))
        ]
    }
    
    private func setupVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBarAppearence() {
        let positionX: CGFloat = 10
        let positionY: CGFloat = 18
        let width = tabBar.bounds.width - positionX * 8
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect:
                CGRect(x: positionX * 4,
                       y: tabBar.bounds.minY - positionY,
                       width: width,
                       height: height),
            cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 3.5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.tabBarMainColorGreen.cgColor
        
        tabBar.tintColor = UIColor.tabBarItemColor
        tabBar.unselectedItemTintColor = UIColor.tabBarItemColorLight
    }
}

