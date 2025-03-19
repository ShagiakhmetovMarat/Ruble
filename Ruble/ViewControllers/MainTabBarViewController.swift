//
//  MainTabBarViewController.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 18.03.2025.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    let viewModel = MainTabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setAppearence()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let firstVC = viewModel.isFirstVC(viewControllers),
           let secondVC = viewModel.isSecondVC(viewControllers) {
            if viewController === viewControllers?[1] {
                firstVC.viewModel.sendDataToSettingViewController()
            } else {
                secondVC.viewModel.sendDataToRubleViewController()
            }
        }
    }
    
    private func setViewControllers() {
        let firstVC = RubleViewController()
        let secondVC = SettingViewController()
        firstVC.tabBarItem = UITabBarItem(title: viewModel.titleFirst,
                                          image: viewModel.imageFirst,
                                          tag: viewModel.tagFirst)
        secondVC.tabBarItem = UITabBarItem(title: viewModel.titleSecond,
                                           image: viewModel.imageSecond,
                                           tag: viewModel.tagSecond)
        viewControllers = [UINavigationController(rootViewController: firstVC),
                           UINavigationController(rootViewController: secondVC)]
        
        firstVC.viewModel.delegate = secondVC
        secondVC.viewModel.delegate = firstVC
    }
    
    private func setAppearence() {
        tabBar.tintColor = .darkGreen
        tabBar.backgroundColor = .white
        self.delegate = self
    }
}
