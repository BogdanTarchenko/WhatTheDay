//
//  DateInformationConfigure.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit
import SnapKit

// MARK: - Configure Methods
extension DateInformationViewController {
    func configureInformationLabel() {
        self.informationLabel.text = "Тут должна быть информация о дате"
        self.informationLabel.numberOfLines = 0
        self.informationLabel.font = .systemFont(ofSize: Constants.informationSizeValue(), weight: .medium)
        self.informationLabel.textAlignment = .center
        self.informationLabel.textColor = UIColor(named: "textPrimaryColor")
        
        self.informationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetValue())
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offsetValue())
        }
    }
}

// MARK: - Constants
extension DateInformationViewController {
    enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static func informationSizeValue() -> CGFloat {
            return screenWidth * 0.06
        }
        
        static func insetValue() -> CGFloat {
            return screenWidth * 0.05
        }
        
        static func offsetValue() -> CGFloat {
            return screenHeight * 0.02
        }
    }
}
