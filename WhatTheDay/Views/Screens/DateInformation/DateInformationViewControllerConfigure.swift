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
    func configureScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureContentView() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    func configureLanguagePicker() {
        self.languagePicker.delegate = self
        self.languagePicker.dataSource = self
        
        self.languagePicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetValue())
            make.top.equalToSuperview()
            make.height.equalTo(Constants.pickerHeightValue())
        }
    }
    
    func configureInformationImage() {
        self.informationImage.image = self.image
        self.informationImage.contentMode = .scaleAspectFit
        
        self.informationImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetValue())
            make.top.equalTo(languagePicker.snp.bottom)
        }
    }
    
    func configureInformationLabel() {
        self.informationLabel.text = self.information
        self.informationLabel.numberOfLines = 0
        self.informationLabel.font = .systemFont(ofSize: Constants.informationSizeValue(), weight: .medium)
        self.informationLabel.textAlignment = .center
        self.informationLabel.textColor = .textPrimary
        
        self.informationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetValue())
            make.top.equalTo(informationImage.snp.bottom).offset(Constants.offsetValue())
            make.bottom.equalToSuperview().offset(-Constants.offsetValue())
        }
    }
}

// MARK: - UIDataPicker methods
extension DateInformationViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLanguage = languages[row]
        translateInformation(to: selectedLanguage.code ?? Constants.defaultLanguageCode) {
            DispatchQueue.main.async {
                self.informationLabel.text = self.information
                self.configureInformationLabel()
            }
        }
    }
}

// MARK: - Constants
extension DateInformationViewController {
    enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let emptyImage = UIImage(systemName: "eye.slash")
        static let emptyString: String = ""
        static let defaultLanguageCode: String = "ru"
        
        static func informationSizeValue() -> CGFloat {
            return screenWidth * 0.06
        }
        
        static func insetValue() -> CGFloat {
            return screenWidth * 0.05
        }
        
        static func offsetValue() -> CGFloat {
            return screenHeight * 0.02
        }
        
        static func pickerHeightValue() -> CGFloat {
            return screenHeight * 0.3
        }
    }
}
