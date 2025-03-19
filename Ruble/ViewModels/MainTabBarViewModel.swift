//
//  MainTabBarViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 18.03.2025.
//

import UIKit

protocol MainTabBarViewModelProtocol {
    var titleFirst: String { get }
    var titleSecond: String { get }
    var imageFirst: UIImage? { get }
    var imageSecond: UIImage? { get }
    var tagFirst: Int { get }
    var tagSecond: Int { get }
    
    func isFirstVC(_ viewControllers: [UIViewController]?) -> RubleViewController?
    func isSecondVC(_ viewControllers: [UIViewController]?) -> SettingViewController?
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    var titleFirst = "Ruble"
    var titleSecond = "Settings"
    var imageFirst = UIImage(systemName: "rublesign")
    var imageSecond = UIImage(systemName: "gear")
    var tagFirst = 0
    var tagSecond = 1
    
    func isFirstVC(_ viewControllers: [UIViewController]?) -> RubleViewController? {
        (viewControllers?[0] as? UINavigationController)?.topViewController as? RubleViewController
    }
    
    func isSecondVC(_ viewControllers: [UIViewController]?) -> SettingViewController? {
        (viewControllers?[1] as? UINavigationController)?.topViewController as? SettingViewController
    }
}
