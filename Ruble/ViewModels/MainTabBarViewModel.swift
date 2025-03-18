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
    var delegate: SettingViewModel { get set }
    
    func sendDataToRubleViewController()
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    var titleFirst = "Ruble"
    var titleSecond = "Settings"
    var imageFirst = UIImage(systemName: "rublesign")
    var imageSecond = UIImage(systemName: "gear")
    var tagFirst = 0
    var tagSecond = 1
    var delegate = SettingViewModel()
    
    func sendDataToRubleViewController() {
        delegate.sendDataToRubleViewController()
    }
}
