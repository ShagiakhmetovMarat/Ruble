//
//  RubleCell.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

class RubleCell: UITableViewCell {
    let viewModel = RubleCellViewModel()
    
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
        viewModel.setCharCode()
        viewModel.setFlagImage()
        viewModel.setValue()
        viewModel.setName()
    }
    
    private func setConstraints() {
        viewModel.setConstraints(contentView)
    }
}
