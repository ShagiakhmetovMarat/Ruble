//
//  CustomKeyboard.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 23.03.2025.
//

import UIKit

protocol CustomKeyboardDelegate: AnyObject {
    func didPressKey(_ key: String)
}

class CustomKeyboard: UIView {
    weak var delegate: CustomKeyboardDelegate?
    private var width: CGFloat = UIScreen.main.bounds.width * 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setKeyboard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setKeyboard()
    }
    
    private func setKeyboard() {
        backgroundColor = .lightGray
        addSubviews(subviews: setButton(title: 1), on: self)
    }
    
    private func addSubviews(subviews: UIView..., on keyboard: UIView) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    @objc private func handleTap(sender: UIButton) {
        delegate?.didPressKey("\(sender.tag)")
    }
}

extension CustomKeyboard {
    private func setButton(title: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.setTitle("\(title)", for: .normal)
        button.frame = CGRect(x: 5, y: 5, width: width, height: 50)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.masksToBounds = false
        button.tag = title
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }
}
