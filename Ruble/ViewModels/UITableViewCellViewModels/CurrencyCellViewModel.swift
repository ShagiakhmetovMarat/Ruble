//
//  CurrencyCellViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import UIKit

protocol CurrencyCellViewModelProtocol {
    var flagImage: UIImageView { get }
    var charCode: UILabel { get }
    var title: UILabel { get }
    
    func addSubviews(on subview: UIView)
    func setImage()
    func setCharCode()
    func setTitle()
    func setConstraints(on contentView: UIView)
}

class CurrencyCellViewModel: CurrencyCellViewModelProtocol {
    var flagImage = UIImageView()
    var charCode = UILabel()
    var title = UILabel()
    
    func addSubviews(on subview: UIView) {
        addSubviews(subviews: flagImage, charCode, title, on: subview)
    }
    
    func setImage() {
        flagImage.clipsToBounds = true
        flagImage.layer.cornerRadius = 4
        flagImage.layer.borderWidth = 1
    }
    
    func setCharCode() {
        charCode.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func setTitle() {
        title.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    func setConstraints(on contentView: UIView) {
        NSLayoutConstraint.activate([
            flagImage.widthAnchor.constraint(equalToConstant: 55),
            flagImage.heightAnchor.constraint(equalToConstant: 40),
            flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            charCode.topAnchor.constraint(equalTo: flagImage.topAnchor),
            charCode.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 15)
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
