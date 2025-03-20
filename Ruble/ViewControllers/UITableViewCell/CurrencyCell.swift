//
//  CurrencyCell.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import UIKit

class CurrencyCell: UITableViewCell {
    let viewModel = CurrencyCellViewModel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews()
        setConfigure()
        setConstraints()
    }
    
    private func addSubviews() {
        viewModel.addSubviews(on: contentView)
    }
    
    private func setConfigure() {
        viewModel.setImage()
        viewModel.setCharCode()
        viewModel.setTitle()
    }
    
    private func setConstraints() {
        viewModel.setConstraints(on: contentView)
    }
}
