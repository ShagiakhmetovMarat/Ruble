//
//  SettingViewController.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 04.05.2023.
//

import UIKit

protocol SettingViewControllerInput {
    func dataToSetting(currency: [Currency])
}

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(viewModel.cell, forCellReuseIdentifier: viewModel.indentifier)
        tableView.backgroundColor = .darkGreen
        tableView.separatorColor = .darkGreen
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = viewModel.heightOfRows
        return tableView
    }()
    
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        addSubviews()
        setConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.indentifier, for: indexPath)
        viewModel.customCell(cell: cell as! SettingCell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        transition(row: indexPath.row)
    }
}

extension SettingViewController: SettingViewControllerInput {
    func dataToSetting(currency: [Currency]) {
        viewModel.saveData(currencies: currency)
    }
}

extension SettingViewController {
    private func setDesign() {
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .darkGreen
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func addSubviews() {
        viewModel.addSubviews(subviews: tableView, on: view)
    }
    
    private func transition(row: Int) {
        switch row {
        case 0: currencyViewController()
        default: break
        }
    }
    
    private func currencyViewController() {
        let currencyViewModel = viewModel.currencyViewController()
        let currencyVC = CurrencyViewController()
        currencyVC.viewModel = currencyViewModel
        currencyVC.viewModel.delegate = self
        currencyVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(currencyVC, animated: true)
    }
}

extension SettingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
