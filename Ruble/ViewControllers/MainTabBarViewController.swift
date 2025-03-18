//
//  MainTabBarViewController.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 18.03.2025.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let viewModel = MainTabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setAppearence()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard item.tag == viewModel.tagFirst else { return }
        viewModel.sendDataToRubleViewController()
    }
    
    private func setViewControllers() {
        let firstVC = UINavigationController(rootViewController: RubleViewController())
        let secondVC = UINavigationController(rootViewController: SettingViewController())
        firstVC.tabBarItem = UITabBarItem(title: viewModel.titleFirst,
                                          image: viewModel.imageFirst,
                                          tag: viewModel.tagFirst)
        secondVC.tabBarItem = UITabBarItem(title: viewModel.titleSecond,
                                           image: viewModel.imageSecond,
                                           tag: viewModel.tagSecond)
        viewControllers = [firstVC, secondVC]
    }
    
    private func setAppearence() {
        tabBar.tintColor = .darkGreen
        tabBar.backgroundColor = .white
    }
}
