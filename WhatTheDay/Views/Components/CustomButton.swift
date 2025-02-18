//
//  CustomButton.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
    func didTapButton()
}

class CustomButton: UIButton {
    // MARK: - Init
    weak var delegate: CustomButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
}

// MARK: - Setup method
extension CustomButton {
    private func setupButton() {
        
        self.backgroundColor = .accent
        
        self.setTitle(NSLocalizedString("findOut", comment: ""), for: .normal)
        self.setTitleColor(.textPrimary, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: Constants.titleSizeValue(), weight: .semibold)
        self.titleLabel?.textAlignment = .center
        
        self.layer.cornerRadius = Constants.cornerRadiusValue()
        self.layer.masksToBounds = true
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

// MARK: - OnTap method
extension CustomButton {
    @objc private func buttonTapped() {
        delegate?.didTapButton()
    }
}

// MARK: - Constants
extension CustomButton {
    enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static func titleSizeValue() -> CGFloat {
            return screenWidth * 0.05
        }
        
        static func cornerRadiusValue() -> CGFloat {
            return screenWidth * 0.05
        }
    }
}
