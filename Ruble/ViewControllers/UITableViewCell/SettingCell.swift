//
//  SettingCell.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 14.03.2025.
//

import UIKit

class SettingCell: UITableViewCell {
    let viewModel = SettingCellViewModel()
    
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
        viewModel.setView()
        viewModel.setImage()
        viewModel.setTitle()
        viewModel.setImageArrow()
    }
    
    private func setConstraints() {
        viewModel.setConstraints(contentView)
    }
}
