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
    var keyboard: CustomKeyboard { get }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func contentSize(_ view: UIView) -> CGSize
    func customCell(cell: RubleCell, indexPath: IndexPath)
    func getCurrencies()
    func fetchData(from url: String)
    func setCustomKeyboard(_ view: UIView)
    func showKeyboard(_ view: UIView)
    func hideKeyboard(_ view: UIView)
    func saveData(currencies: [Currency])
    func sendDataToSettingViewController()
}

class RubleViewModel: RubleViewModelProtocol, CustomKeyboardDelegate {
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
    var keyboard = CustomKeyboard()
    private var currency: [Currency] = []
    private var activeCurrencies: [Currency] {
        currency.filter({$0.isOn})
    }
    private var dataCurrencies: [DataCurrency] = []
    private let keyboardHeight: CGFloat = 300
    
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
    
    func setCustomKeyboard(_ view: UIView) {
        keyboard.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: keyboardHeight)
        keyboard.delegate = self
        view.addSubview(keyboard)
    }
    
    func showKeyboard(_ view: UIView) {
        UIView.animate(withDuration: 0.3) { [self] in
            keyboard.frame.origin.y = view.frame.height - keyboardHeight
        }
    }
    
    func hideKeyboard(_ view: UIView) {
        UIView.animate(withDuration: 0.3) {
            self.keyboard.frame.origin.y = view.frame.height
        }
    }
    
    func didPressKey(_ key: String) {
        print("Hello, \(key)")
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
    
    private func string(_ value: CGFloat) -> String {
        String(format: "%.2f", value)
    }
    
    private func value(_ indexPath: IndexPath) -> CGFloat {
        let charCode = activeCurrencies[indexPath.section].charCode
        let value = dataCurrencies.filter({ $0.CharCode == charCode }).first?.Value ?? 0
        let nominal = dataCurrencies.filter({ $0.CharCode == charCode }).first?.Nominal ?? 0
        return setValue(nominal, and: value)
    }
    
    private func setValue(_ nominal: Int, and value: CGFloat) -> CGFloat {
        nominal > 1 ? value / CGFloat(nominal) : value
    }
}
