//
//  SettingCellViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

protocol SettingCellViewModelProtocol {
    var view: UIView { get }
    var image: UIImageView { get }
    var title: UILabel { get }
    var imageArrow: UIImageView { get }
    
    func addSubviews(on subview: UIView)
    func setView()
    func setImage()
    func setTitle()
    func setImageArrow()
    func setConstraints(_ contentView: UIView)
}

class SettingCellViewModel: SettingCellViewModelProtocol {
    var view = UIView()
    var image = UIImageView()
    var title = UILabel()
    var imageArrow = UIImageView()
    
    func addSubviews(on subview: UIView) {
        addSubviews(subviews: view, image, title, imageArrow, on: subview)
    }
    
    func setView() {
        view.layer.cornerRadius = 9
    }
    
    func setImage() {
        image.tintColor = .white
    }
    
    func setTitle() {
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .black
    }
    
    func setImageArrow() {
        let size = UIImage.SymbolConfiguration(pointSize: 20)
        imageArrow.image = UIImage(systemName: "chevron.right", withConfiguration: size)
        imageArrow.tintColor = .darkGreen
    }
    
    func setConstraints(_ contentView: UIView) {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 40),
            view.heightAnchor.constraint(equalToConstant: 40),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            imageArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

extension SettingCellViewModel {
    private func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
