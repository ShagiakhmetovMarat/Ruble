//
//  RubleViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

protocol RubleViewModelProtocol {
    var title: ((String) -> Void)? { get }
    var tableViewUpdated: (() -> Void)? { get }
    var cell: AnyClass { get }
    var identifier: String { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    var heightOfRows: CGFloat { get }
    var heightOfDistance: CGFloat { get }
    var delegate: SettingViewControllerInput? { get set }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func contentSize(_ view: UIView) -> CGSize
    func customCell(cell: RubleCell, indexPath: IndexPath)
    func getCurrencies()
    func fetchData(from url: String)
    func saveData(currencies: [Currency])
    func sendDataToSettingViewController()
}

class RubleViewModel: RubleViewModelProtocol {
    var title: ((String) -> Void)?
    var tableViewUpdated: (() -> Void)?
    var cell: AnyClass = RubleCell.self
    var identifier = "cell"
    var numberOfRows = 1
    var numberOfSections: Int {
        activeCurrencies.count
    }
    var heightOfRows: CGFloat = 75
    var heightOfDistance: CGFloat = 7
    var delegate: SettingViewControllerInput?
    private var currency: [Currency] = []
    private var activeCurrencies: [Currency] {
        currency.filter({$0.isOn})
    }
    private var dataCurrencies: [DataCurrency] = []
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func contentSize(_ view: UIView) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
    func customCell(cell: RubleCell, indexPath: IndexPath) {
        cell.viewModel.charCode.text = charCode(indexPath)
        cell.viewModel.flagImage.image = UIImage(named: activeCurrencies[indexPath.section].flag)
        cell.viewModel.value.text = string(value(indexPath))
        cell.viewModel.name.text = activeCurrencies[indexPath.section].name
        cell.contentView.backgroundColor = .darkGreen
    }
    
    func getCurrencies() {
        currency = fetchCurrencies()
    }
    
    func fetchData(from url: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        NetworkManager.shared.fetchData(from: url) { _, valutes in
            DispatchQueue.main.async {
                self.dataCurrencies = valutes
                self.tableViewUpdated?()
                self.title?("Currency as " + formatter.string(from: date))
            }
        }
    }
    
    func saveData(currencies: [Currency]) {
        currency = currencies
        tableViewUpdated?()
    }
    
    func sendDataToSettingViewController() {
        delegate?.dataToSetting(currency: currency)
    }
}

extension RubleViewModel {
    private func fetchCurrencies() -> [Currency] {
        let currencies = StorageManager.shared.fetchData()
        return currencies.isEmpty ? getData() : currencies
    }
    
    private func getData() -> [Currency] {
        var currency: [Currency] = []
        
        let flags = DataManager.shared.flag
        let charCodes = DataManager.shared.charCode
        let names = DataManager.shared.name
        let iterrationCount = min(flags.count, charCodes.count, names.count)
        
        for index in 0..<iterrationCount {
            let info = Currency(flag: flags[index],
                                charCode: charCodes[index],
                                name: names[index],
                                isOn: false)
            currency.append(info)
        }
        
        return currency
    }
    
    private func charCode(_ indexPath: IndexPath) -> String {
        dataCurrencies.filter({ $0.CharCode == activeCurrencies[indexPath.section].charCode }).first?.CharCode ?? ""
    }
    
    private func string(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
    
    private func value(_ indexPath: IndexPath) -> Double {
        dataCurrencies.filter({ $0.CharCode == activeCurrencies[indexPath.section].charCode }).first?.Value ?? 0
    }
}
