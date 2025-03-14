//
//  RubleViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

protocol RubleViewModelProtocol {
    var cell: AnyClass { get }
    var identifier: String { get }
    var numberOfRows: Int { get }
    var heightOfRows: CGFloat { get }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func contentSize(_ view: UIView) -> CGSize
    func customCell(cell: RubleCell, indexPath: IndexPath)
}

class RubleViewModel: RubleViewModelProtocol {
    var cell: AnyClass = RubleCell.self
    var identifier = "cell"
    var numberOfRows = 1
    var heightOfRows: CGFloat = 125
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func contentSize(_ view: UIView) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
    func customCell(cell: RubleCell, indexPath: IndexPath) {
        cell.viewModel.charCode.text = "USD"
        cell.viewModel.flagImage.image = UIImage(named: "usa")
        cell.viewModel.value.text = "89.54"
        cell.viewModel.name.text = "US Dollar"
        cell.contentView.backgroundColor = .systemBlue
    }
}
