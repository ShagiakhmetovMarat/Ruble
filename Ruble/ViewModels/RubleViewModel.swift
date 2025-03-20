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
    var title: String { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    var heightOfRows: CGFloat { get }
    var delegate: SettingViewControllerInput? { get set }
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView)
    func contentSize(_ view: UIView) -> CGSize
    func customCell(cell: RubleCell, indexPath: IndexPath)
    func fetchData(from url: String, and tableView: UITableView)
    func saveData(currencies: [Currency])
    func sendDataToSettingViewController()
}

class RubleViewModel: RubleViewModelProtocol {
    var cell: AnyClass = RubleCell.self
    var identifier = "cell"
    var title: String {
        dateTitle
    }
    var numberOfRows = 1
    var numberOfSections: Int {
        2//activeCurrencies.count
    }
    var heightOfRows: CGFloat = 125
    var delegate: SettingViewControllerInput?
    private var currency: [Currency] = []
    private var activeCurrencies: [Currency] {
        currency.filter({$0.isOn})
    }
    private var dataCurrencies: [DataCurrency] = []
    private var dateTitle = String()
    
    func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func contentSize(_ view: UIView) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
    func customCell(cell: RubleCell, indexPath: IndexPath) {
        cell.viewModel.charCode.text = "USD"//activeCurrencies[indexPath.row].charCode
        cell.viewModel.flagImage.image = UIImage(named: "usa")//UIImage(named: activeCurrencies[indexPath.row].flag)
        cell.viewModel.value.text = "89.54"
        cell.viewModel.name.text = "Dollar US"//activeCurrencies[indexPath.row].name
        cell.contentView.backgroundColor = .darkGreen
    }
    
    func fetchData(from url: String, and tableView: UITableView) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        NetworkManager.shared.fetchData(from: url) { _, valutes in
            DispatchQueue.main.async { [self] in
                dataCurrencies = valutes
                tableView.reloadData()
                dateTitle = "Exchange rates as of" + formatter.string(from: date)
            }
        }
    }
    
    func saveData(currencies: [Currency]) {
        currency = currencies
    }
    
    func sendDataToSettingViewController() {
        delegate?.dataToSetting(currency: currency)
    }
}

extension RubleViewModel {
    private func value(_ indexPath: IndexPath) -> String {
        ""
    }
    
//    private func charCode(_ indexPath: IndexPath) -> String {
//        dataCurrencies.filter({ _ in activeCurrencies[indexPath.row].charCode })
//    }
}
