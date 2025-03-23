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
    var tableViewUpdated: (() -> Void)? { get set }
    var delegate: SettingViewControllerInput! { get set }
    
    init(currency: [Currency])
    
    func customCell(cell: CurrencyCell, indexPath: IndexPath)
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func setSortedList()
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
    var heightOfRow: CGFloat = 50
    var tableViewUpdated: (() -> Void)?
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
        cell.viewModel.flagImage.image = image(indexPath)
        cell.viewModel.charCode.text = charCode(indexPath)
        cell.viewModel.title.text = name(indexPath)
    }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func setSortedList() {
        if activeCurrencies.isEmpty {
            currency.sort { $0.name < $1.name }
        } else {
            activeCurrencies.sort { $0.name < $1.name }
            unactiveCurrencies.sort { $0.name < $1.name }
        }
        tableViewUpdated?()
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
        currencyToggle(indexPath: indexPath)
        setNumberRow(indexPath: indexPath)
        moveRow(tableView: tableView, and: indexPath)
        StorageManager.shared.saveData(currency: activeCurrencies + unactiveCurrencies)
    }
    
    func sendDataToSetting() {
        delegate.dataToSetting(currency: activeCurrencies + unactiveCurrencies)
    }
}

extension CurrencyViewModel {
    private func title(_ section: Int) -> String {
        section == 0 ? "Active currencies" : "Unactive currencies"
    }
    
    private func image(_ indexPath: IndexPath) -> UIImage? {
        indexPath.section == 0 ? flag(activeCurrencies[indexPath.row].flag) : flag(unactiveCurrencies[indexPath.row].flag)
    }
    
    private func flag(_ named: String) -> UIImage? {
        UIImage(named: named)
    }
    
    private func charCode(_ indexPath: IndexPath) -> String {
        indexPath.section == 0 ? activeCurrencies[indexPath.row].charCode : unactiveCurrencies[indexPath.row].charCode
    }
    
    private func name(_ indexPath: IndexPath) -> String {
        indexPath.section == 0 ? activeCurrencies[indexPath.row].name : unactiveCurrencies[indexPath.row].name
    }
    
    private func currencyToggle(indexPath: IndexPath) {
        if indexPath.section == 0 {
            activeCurrencies[indexPath.row].isOn.toggle()
        } else {
            unactiveCurrencies[indexPath.row].isOn.toggle()
        }
    }
    
    private func setNumberRow(indexPath: IndexPath) {
        if indexPath.section == 0 {
            let currency = activeCurrencies.remove(at: indexPath.row)
            unactiveCurrencies.append(currency)
        } else {
            let currency = unactiveCurrencies.remove(at: indexPath.row)
            activeCurrencies.append(currency)
        }
    }
    
    private func moveRow(tableView: UITableView, and indexPath: IndexPath) {
        let indexPathActive = IndexPath(row: activeCurrencies.count - 1, section: 0)
        let indexPathUnactive = IndexPath(row: unactiveCurrencies.count - 1, section: 1)
        let destination = indexPath.section == 0 ? indexPathUnactive : indexPathActive
        tableView.moveRow(at: indexPath, to: destination)
    }
}
