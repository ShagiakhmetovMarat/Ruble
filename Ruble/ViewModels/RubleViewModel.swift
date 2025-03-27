//
//  RubleViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit
import AVFoundation

protocol RubleViewModelProtocol {
    var title: ((String) -> Void)? { get }
    var tableViewUpdated: (() -> Void)? { get }
    var isHiddenTabBar: ((Bool) -> Void)? { get }
    var cell: AnyClass { get }
    var identifier: String { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    var heightOfRows: CGFloat { get }
    var heightOfDistance: CGFloat { get }
    var isOnKeyboard: Bool { get }
    var index: IndexPath? { get }
    var delegate: SettingViewControllerInput? { get set }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func contentSize(_ view: UIView) -> CGSize
    func customCell(cell: RubleCell, indexPath: IndexPath)
    func getCurrencies()
    func fetchData(from url: String)
    func showKeyboard(keyboard: UIView, stackView: UIStackView, and view: UIView)
    func hideKeyboard(keyboard: UIView, gesture: UITapGestureRecognizer, and view: UIView)
    func hideKeyboardFromScroll(keyboard: UIView, and view: UIView)
    func playTapSound()
    func playBackSound()
    func isSelected(tableView: UITableView, and indexPath: IndexPath)
    func setValue(sender: UIButton)
    func saveData(currencies: [Currency])
    func sendDataToSettingViewController()
}

class RubleViewModel: RubleViewModelProtocol {
    var title: ((String) -> Void)?
    var tableViewUpdated: (() -> Void)?
    var isHiddenTabBar: ((Bool) -> Void)?
    var cell: AnyClass = RubleCell.self
    var identifier = "cell"
    var numberOfRows = 1
    var numberOfSections: Int {
        activeCurrencies.count
    }
    var heightOfRows: CGFloat = 75
    var heightOfDistance: CGFloat = 7
    var isOnKeyboard: Bool = false
    var index: IndexPath?
    var delegate: SettingViewControllerInput?
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
        cell.viewModel.charCode.text = activeCurrencies[indexPath.section].charCode
        cell.viewModel.flagImage.image = UIImage(named: activeCurrencies[indexPath.section].flag)
        cell.viewModel.value.text = string(activeCurrencies[indexPath.section].value)
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
    
    func showKeyboard(keyboard: UIView, stackView: UIStackView, and view: UIView) {
        guard !isOnKeyboard else { return }
        addSubviews(subviews: keyboard, on: view)
        setConstraints(keyboard, stackView, and: view)
        showKeyboard(keyboard: keyboard, and: view)
        isOnKeyboard.toggle()
        isHiddenTabBar?(true)
    }
    
    func hideKeyboard(keyboard: UIView, gesture: UITapGestureRecognizer, and view: UIView) {
        guard isOnKeyboard else { return }
        let location = gesture.location(in: view)
        if !keyboard.frame.contains(location) {
            hideKeyboard(keyboard: keyboard, and: view)
            isHiddenTabBar?(false)
            tableViewUpdated?()
            index = nil
        }
    }
    
    func hideKeyboardFromScroll(keyboard: UIView, and view: UIView) {
        guard isOnKeyboard else { return }
        hideKeyboard(keyboard: keyboard, and: view)
        isHiddenTabBar?(false)
        tableViewUpdated?()
        index = nil
    }
    
    func playTapSound() {
        AudioServicesPlaySystemSound(1104)
    }
    
    func playBackSound() {
        AudioServicesPlaySystemSound(1155)
    }
    
    func isSelected(tableView: UITableView, and indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RubleCell {
            cell.viewModel.value.textColor = cell.viewModel.value.textColor == .white ? .systemGray2 : .white
            index = indexPath
        }
    }
    
    func setValue(sender: UIButton) {
        if let index = index {
            
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
                                isOn: false,
                                value: 0)
            currency.append(info)
        }
        
        return currency
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
    
    private func setConstraints(_ keyboard: UIView, _ stackView: UIStackView, and view: UIView) {
        NSLayoutConstraint.activate([
            keyboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboard.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: keyboard.topAnchor, constant: 7),
            stackView.leadingAnchor.constraint(equalTo: keyboard.leadingAnchor, constant: 7),
            stackView.trailingAnchor.constraint(equalTo: keyboard.trailingAnchor, constant: -7),
            stackView.bottomAnchor.constraint(equalTo: keyboard.bottomAnchor, constant: -87)
        ])
    }
    
    private func showKeyboard(keyboard: UIView, and view: UIView) {
        keyboard.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.5) {
            keyboard.transform = .identity
        }
    }
    
    private func hideKeyboard(keyboard: UIView, and view: UIView) {
        UIView.animate(withDuration: 0.5) {
            keyboard.transform = CGAffineTransform.init(translationX: 0, y: view.frame.height)
        } completion: { _ in
            keyboard.removeFromSuperview()
            self.isOnKeyboard.toggle()
        }
    }
}
