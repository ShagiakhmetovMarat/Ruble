//
//  RubleViewController.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 04.05.2023.
//

import UIKit

protocol RubleViewControllerInput {
    func dataToRuble(currency: [Currency])
}

class RubleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(viewModel.cell, forCellReuseIdentifier: viewModel.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = viewModel.heightOfRows
        tableView.backgroundColor = .lightGreen
        return tableView
    }()
    
    let viewModel = RubleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        addSubviews()
//        fetchData()
        setConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.identifier, for: indexPath)
        viewModel.customCell(cell: cell as! RubleCell, indexPath: indexPath)
        return cell
    }
}

extension RubleViewController {
    private func setDesign() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .darkGreen
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
    }
    
    private func addSubviews() {
        viewModel.addSubviews(subviews: tableView, on: view)
    }
    
    private func fetchData() {
        viewModel.fetchData(from: URLS.currencyAPI.rawValue, and: tableView)
    }
}

extension RubleViewController: RubleViewControllerInput {
    func dataToRuble(currency: [Currency]) {
        viewModel.saveData(currencies: currency)
    }
}

extension RubleViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
