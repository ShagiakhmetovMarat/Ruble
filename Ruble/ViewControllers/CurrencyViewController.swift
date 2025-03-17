//
//  CurrencyViewController.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import UIKit

class CurrencyViewController: UITableViewController {
    private lazy var listOfCurrency: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(viewModel.cell, forCellReuseIdentifier: viewModel.identifier)
        tableView.backgroundColor = .darkGreen
        tableView.separatorColor = .darkGreen
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = viewModel.heightOfRow
        return tableView
    }()
    
    var viewModel: CurrencyViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        addSubviews()
        setConstraints()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.identifier, for: indexPath)
        viewModel.customCell(cell: cell as! CurrencyCell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CurrencyViewController {
    private func setDesign() {
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .darkGreen
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
    }
    
    private func addSubviews() {
        viewModel.addSubviews(subviews: listOfCurrency, on: view)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            listOfCurrency.topAnchor.constraint(equalTo: view.topAnchor),
            listOfCurrency.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listOfCurrency.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listOfCurrency.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
