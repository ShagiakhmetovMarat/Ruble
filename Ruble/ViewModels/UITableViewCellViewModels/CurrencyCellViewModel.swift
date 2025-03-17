//
//  CurrencyCellViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import UIKit

protocol CurrencyCellViewModelProtocol {
    var flagImage: UIImageView { get }
    var title: UILabel { get }
    
    func addSubviews(on subview: UIView)
    func setImage()
    func setTitle()
    func setConstraints(on contentView: UIView)
}

class CurrencyCellViewModel: CurrencyCellViewModelProtocol {
    var flagImage = UIImageView()
    var title = UILabel()
    
    func addSubviews(on subview: UIView) {
        addSubviews(subviews: flagImage, title, on: subview)
    }
    
    func setImage() {
        flagImage.clipsToBounds = true
        flagImage.layer.cornerRadius = 4
        flagImage.layer.borderWidth = 1
    }
    
    func setTitle() {
        title.font = .systemFont(ofSize: 25, weight: .medium)
    }
    
    func setConstraints(on contentView: UIView) {
        NSLayoutConstraint.activate([
            flagImage.widthAnchor.constraint(equalToConstant: 90),
            flagImage.heightAnchor.constraint(equalToConstant: 55),
            flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 25)
        ])
    }
}

extension CurrencyCellViewModel {
    private func addSubviews(subviews: UIView..., on otherSubviews: UIView) {
        subviews.forEach { subview in
            otherSubviews.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
