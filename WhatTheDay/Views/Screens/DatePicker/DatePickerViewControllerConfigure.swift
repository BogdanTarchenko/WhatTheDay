//
//  DatePickerViewControllerConfigure.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 03.08.2024.
//

import UIKit
import SnapKit

// MARK: - Configure Methods
extension DatePickerViewController {
    func configureTitleImage() {
        
        self.titleImage.image = UIImage(systemName: "questionmark")
        self.titleImage.tintColor = UIColor(named: "textPrimaryColor")
        
        self.titleImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offsetValue())
            make.width.equalTo(Constants.titleImageWidth())
            make.height.equalTo(titleImage.snp.width).multipliedBy(Constants.imageAspectRatio)
        }
    }
    
    func configureTitleLabel() {
        
        self.titleLabel.text = NSLocalizedString("whatsTheDay", comment: "")
        self.titleLabel.font = .systemFont(ofSize: Constants.titleSizeValue(), weight: .bold)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor(named: "textPrimaryColor")
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleImage.snp.bottom).offset(Constants.offsetValue())
        }
    }
    
    func configureDatePicker() {
        
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        
        self.datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.offsetValue())
        }
    }
    
    func configureButton() {
        
        self.button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(datePicker.snp.bottom).offset(Constants.offsetValue())
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.offsetValue())
            make.width.equalTo(Constants.buttonWidth())
            make.height.equalTo(Constants.buttonHeight())
        }
    }
}

// MARK: - Constants
extension DatePickerViewController {
    enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let imageAspectRatio = 1.35
        
        static func titleSizeValue() -> CGFloat {
            return screenWidth * 0.1
        }
        
        static func offsetValue() -> CGFloat {
            return screenHeight * 0.02
        }
        
        static func titleImageWidth() -> CGFloat {
            return screenWidth * 0.7
        }
        
        static func buttonWidth() -> CGFloat {
            return screenWidth * 0.7
        }
        
        static func buttonHeight() -> CGFloat {
            return screenHeight * 0.08
        }
    }
}
