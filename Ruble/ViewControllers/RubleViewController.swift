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
        tableView.sectionHeaderHeight = viewModel.heightOfDistance
        tableView.sectionFooterHeight = viewModel.heightOfDistance
        tableView.backgroundColor = .lightGreen
        return tableView
    }()
    
    private lazy var buttonOne: UIButton = {
        setButton(title: "1")
    }()
    
    private lazy var buttonTwo: UIButton = {
        setButton(title: "2")
    }()
    
    private lazy var buttonThree: UIButton = {
        setButton(title: "3")
    }()
    
    private lazy var buttonFour: UIButton = {
        setButton(title: "4")
    }()
    
    private lazy var buttonFive: UIButton = {
        setButton(title: "5")
    }()
    
    private lazy var buttonSix: UIButton = {
        setButton(title: "6")
    }()
    
    private lazy var buttonSeven: UIButton = {
        setButton(title: "7")
    }()
    
    private lazy var buttonEight: UIButton = {
        setButton(title: "8")
    }()
    
    private lazy var buttonNine: UIButton = {
        setButton(title: "9")
    }()
    
    private lazy var buttonZero: UIButton = {
        setButton(title: "0")
    }()
    
    private lazy var buttonDot: UIButton = {
        setButton()
    }()
    
    private lazy var buttonDelete: UIButton = {
        setButton(image: "delete.left")
    }()
    
    private lazy var stackViewOne: UIStackView = {
        setStackView(buttonOne, buttonTwo, and: buttonThree)
    }()
    
    private lazy var stackViewTwo: UIStackView = {
        setStackView(buttonFour, buttonFive, and: buttonSix)
    }()
    
    private lazy var stackViewThree: UIStackView = {
        setStackView(buttonSeven, buttonEight, and: buttonNine)
    }()
    
    private lazy var stackViewFour: UIStackView = {
        setStackView(buttonDot, buttonZero, and: buttonDelete)
    }()
    
    private lazy var stackView: UIStackView = {
        setStackViews(stackViewOne, stackViewTwo, stackViewThree, and: stackViewFour)
    }()
    
    private lazy var keyboard: UIView = {
        let keyboard = UIView()
        keyboard.backgroundColor = .systemGray5
        keyboard.addSubview(stackView)
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        return keyboard
    }()
    
    let viewModel = RubleViewModel()
    var enableInputClicksWhenVisible: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        addSubviews()
        fetchData()
        updateData()
        setTapGesture()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showKeyboard(keyboard: keyboard, stackView: stackView, and: view)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.hideKeyboardFromScroll(keyboard: keyboard, and: view)
    }
}

extension RubleViewController {
    private func setDesign() {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = .darkGreen
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        viewModel.addSubviews(subviews: tableView, on: view)
    }
    
    private func fetchData() {
        viewModel.getCurrencies()
        viewModel.fetchData(from: URLS.currencyAPI.rawValue)
    }
    
    private func updateData() {
        viewModel.title = { [weak self] newTitle in
            self?.navigationItem.title = newTitle
        }
        viewModel.tableViewUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.isHiddenTabBar = { [weak self] isOn in
            UIView.animate(withDuration: 0.5) {
                self?.tabBarController?.tabBar.alpha = isOn ? 0 : 1
            }
        }
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        viewModel.hideKeyboard(keyboard: keyboard, gesture: gesture, and: view)
    }
    
    @objc private func handleButton(_ sender: UIButton) {
        
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

extension RubleViewController {
    private func setButton(title: String) -> UIButton {
        let button = ButtonNumber(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = Int(title) ?? 0
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }
    
    private func setButton(image: String) -> UIButton {
        let size = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: image, withConfiguration: size)
        let button = ButtonDelete(type: .custom)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }
    
    private func setButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        button.setTitle(".", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }
}

extension RubleViewController {
    private func setStackView(_ first: UIView, _ second: UIView, and third: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first, second, third])
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setStackViews(_ first: UIView, _ second: UIView, _ third: UIView, and fourth: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first, second, third, fourth])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
