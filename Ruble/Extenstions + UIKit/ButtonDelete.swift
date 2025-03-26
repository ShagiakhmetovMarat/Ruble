//
//  ButtonDelete.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 26.03.2025.
//

import UIKit

class ButtonDelete: UIButton {
    override var isHighlighted: Bool {
        didSet {
            let size = UIImage.SymbolConfiguration(pointSize: 25)
            let systemName = isHighlighted ? "delete.left.fill" : "delete.left"
            let image = UIImage(systemName: systemName, withConfiguration: size)
            setImage(image, for: .normal)
            tintColor = .black
        }
    }
}
