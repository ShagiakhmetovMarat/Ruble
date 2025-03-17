//
//  CurrencyViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import UIKit

protocol CurrencyViewModelProtocol {
    var title: String { get }
    var cell: AnyClass { get }
    var identifier: String { get }
    var numberOfRows: Int { get }
    var heightOfRow: CGFloat { get }
    
    init(currency: [Currency])
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath)
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
}

class CurrencyViewModel: CurrencyViewModelProtocol {
    var title = "Currency"
    var cell: AnyClass = CurrencyCell.self
    var identifier = "cell"
    var numberOfRows: Int {
        currency.count
    }
    var heightOfRow: CGFloat = 60
    private var currency: [Currency] = []
    
    required init(currency: [Currency]) {
        self.currency = currency
    }
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath) {
        cell.viewModel.flagImage.image = UIImage(named: currency[indexPath.row].flag)
        cell.viewModel.title.text = currency[indexPath.row].name
    }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
}
