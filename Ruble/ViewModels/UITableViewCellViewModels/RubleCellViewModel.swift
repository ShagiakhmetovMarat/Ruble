//
//  RubleCellViewModel.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

protocol RubleCellViewModelProtocol {
    var charCode: UILabel { get }
    var flagImage: UIImageView { get }
    var value: UILabel { get }
    var name: UILabel { get }
    
    func addSubviews(on subview: UIView)
    func setCharCode()
    func setFlagImage()
    func setValue()
    func setName()
    func setConstraints(_ contentView: UIView)
}

class RubleCellViewModel: RubleCellViewModelProtocol {
    var charCode = UILabel()
    var flagImage = UIImageView()
    var value = UILabel()
    var name = UILabel()
    
    func addSubviews(on subview: UIView) {
        addSubviews(subviews: charCode, flagImage, value, name, on: subview)
    }
    
    func setCharCode() {
        charCode.font = .systemFont(ofSize: 22, weight: .bold)
        charCode.textColor = .white
    }
    
    func setFlagImage() {
        flagImage.clipsToBounds = true
        flagImage.layer.cornerRadius = 4
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.white.cgColor
    }
    
    func setValue() {
        value.font = .systemFont(ofSize: 35, weight: .semibold)
        value.textColor = .white
    }
    
    func setName() {
        name.font = .systemFont(ofSize: 16, weight: .regular)
        name.textColor = .white
    }
    
    func setConstraints(_ contentView: UIView) {
        NSLayoutConstraint.activate([
            charCode.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            charCode.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            flagImage.widthAnchor.constraint(equalToConstant: 90),
            flagImage.heightAnchor.constraint(equalToConstant: 55),
            flagImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            flagImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            value.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            value.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

extension RubleCellViewModel {
    private func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
