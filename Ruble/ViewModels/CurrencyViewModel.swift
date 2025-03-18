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
    var delegate: SettingViewControllerInput! { get set }
    
    init(currency: [Currency])
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath)
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func toggle(tableView: UITableView, and indexPath: IndexPath)
    func sendDataToSetting()
}

class CurrencyViewModel: CurrencyViewModelProtocol {
    var title = "Currency"
    var cell: AnyClass = CurrencyCell.self
    var identifier = "cell"
    var numberOfRows: Int {
        currency.count
    }
    var heightOfRow: CGFloat = 45
    var delegate: SettingViewControllerInput!
    private var currency: [Currency] = []
    
    required init(currency: [Currency]) {
        self.currency = currency
    }
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath) {
        cell.viewModel.flagImage.image = UIImage(named: currency[indexPath.row].flag)
        cell.viewModel.title.text = currency[indexPath.row].name
        cell.accessoryType = isCheckmark(isOn: currency[indexPath.row].isOn)
        cell.tintColor = .darkGreen
    }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func toggle(tableView: UITableView, and indexPath: IndexPath) {
        currency[indexPath.row].isOn.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        StorageManager.shared.saveData(currency: currency)
    }
    
    func sendDataToSetting() {
        delegate.dataToSetting(currency: currency)
    }
}

extension CurrencyViewModel {
    private func isCheckmark(isOn: Bool) -> UITableViewCell.AccessoryType {
        isOn ? .checkmark : .none
    }
}
