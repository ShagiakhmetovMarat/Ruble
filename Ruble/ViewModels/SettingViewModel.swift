//
//  SettingViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

protocol SettingViewModelProtocol {
    var title: String { get }
    var cell: AnyClass { get }
    var indentifier: String { get }
    var numberOfRows: Int { get }
    var heightOfRows: CGFloat { get }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func customCell(cell: SettingCell, indexPath: IndexPath)
}

class SettingViewModel: SettingViewModelProtocol {
    var title = "Settings"
    var cell: AnyClass = SettingCell.self
    var indentifier = "cell"
    var numberOfRows = 2
    var heightOfRows: CGFloat = 55
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func customCell(cell: SettingCell, indexPath: IndexPath) {
        cell.viewModel.view.backgroundColor = color(indexPath.row)
        cell.viewModel.image.image = image(name: images(indexPath.row))
        cell.viewModel.title.text = text(indexPath.row)
    }
}

extension SettingViewModel {
    private func color(_ row: Int) -> UIColor {
        switch row {
        case 0: .systemGreen
        default: .systemBlue
        }
    }
    
    private func image(name: String) -> UIImage? {
        let size = UIImage.SymbolConfiguration(pointSize: 30)
        return UIImage(systemName: name, withConfiguration: size)
    }
    
    private func images(_ row: Int) -> String {
        switch row {
        case 0: "rublesign"
        default: "globe"
        }
    }
    
    private func text(_ row: Int) -> String {
        switch row {
        case 0: "Currency"
        default: "Language"
        }
    }
}
