//
//  ButtonNumber + Extension.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 24.03.2025.
//

import UIKit

class ButtonNumber: UIButton {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: isHighlighted ? 0 : 0.2,
                delay: 0,
                options: [.beginFromCurrentState, .allowUserInteraction]) {
                    self.backgroundColor = self.isHighlighted ? .systemGray2 : .white
                }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
    }
}
