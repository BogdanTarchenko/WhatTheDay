//
//  CustomButton.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit

class CustomButton: UIButton {
// MARK: - Init
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
        
        self.backgroundColor = UIColor(named: "buttonColor")
        
        self.setTitle(NSLocalizedString("findOut", comment: ""), for: .normal)
        self.setTitleColor(.systemBackground, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: Constants.titleSizeValue(), weight: .semibold)
        self.titleLabel?.textAlignment = .center
        
        self.layer.cornerRadius = Constants.cornerRadiusValue()
        self.layer.masksToBounds = true
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
