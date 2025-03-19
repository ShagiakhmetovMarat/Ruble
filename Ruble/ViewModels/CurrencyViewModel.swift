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
    var numberOfSection: Int { get }
    var heightOfRow: CGFloat { get }
    var delegate: SettingViewControllerInput! { get set }
    
    init(currency: [Currency])
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath)
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func titleHeader(_ section: Int) -> UIView
    func numberOfRows(_ section: Int) -> Int
    func toggle(tableView: UITableView, and indexPath: IndexPath)
    func sendDataToSetting()
}

class CurrencyViewModel: CurrencyViewModelProtocol {
    var title = "Currency"
    var cell: AnyClass = CurrencyCell.self
    var identifier = "cell"
    var numberOfSection = 2
    var heightOfRow: CGFloat = 45
    var delegate: SettingViewControllerInput!
    private var currency: [Currency] = []
    private var activeCurrencies: [Currency] = []
    private var unactiveCurrencies: [Currency] = []
    
    required init(currency: [Currency]) {
        self.currency = currency
        self.activeCurrencies = currency.filter({$0.isOn})
        self.unactiveCurrencies = currency.filter({!$0.isOn})
    }
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath) {
        cell.viewModel.flagImage.image = image(indexPath.section)[indexPath.row]
        cell.viewModel.title.text = name(indexPath.section)[indexPath.row]
        cell.accessoryType = checkmark(indexPath.section)
        cell.tintColor = .darkGreen
    }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func titleHeader(_ section: Int) -> UIView {
        let label = UILabel()
        label.text = title(section).uppercased()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }
    
    func numberOfRows(_ section: Int) -> Int {
        section == 0 ? activeCurrencies.count : unactiveCurrencies.count
    }
    
    func toggle(tableView: UITableView, and indexPath: IndexPath) {
//        currency[indexPath.row].isOn.toggle()
        print("\(currency[indexPath.row])")
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//        StorageManager.shared.saveData(currency: currency)
//        moveRow(tableView: tableView, and: indexPath)
    }
    
    func sendDataToSetting() {
        delegate.dataToSetting(currency: currency)
    }
}

extension CurrencyViewModel {
    private func title(_ section: Int) -> String {
        section == 0 ? "Active currencies" : "Unactive currencies"
    }
    
    private func image(_ section: Int) -> [UIImage?] {
        images(flags(isOn(section: section, and: currency)))
    }
    
    private func name(_ section: Int) -> [String] {
        names(isOn(section: section, and: currency))
    }
    
    private func checkmark(_ section: Int) -> UITableViewCell.AccessoryType {
        section == 0 ? .checkmark : .none
    }
    
    private func isOn(section: Int, and currencies: [Currency]) -> [Currency] {
        section == 0 ? currencies.filter({$0.isOn}) : currencies.filter({!$0.isOn})
    }
    
    private func flags(_ currencies: [Currency]) -> [String] {
        currencies.map({$0.flag})
    }
    
    private func names(_ currencies: [Currency]) -> [String] {
        currencies.map({$0.name})
    }
    
    private func images(_ currencies: [String]) -> [UIImage?] {
        var images: [UIImage?] = []
        currencies.forEach { named in
            images.append(UIImage(named: named))
        }
        return images
    }
    
    private func moveRow(tableView: UITableView, and indexPath: IndexPath) {
        let indexPathActive = IndexPath(row: activeCurrencies.count - 1, section: 0)
        let indexPathUnactive = IndexPath(row: unactiveCurrencies.count - 1, section: 1)
        let destination = indexPath.section == 0 ? indexPathUnactive : indexPathActive
        tableView.moveRow(at: indexPath, to: destination)
    }
}
