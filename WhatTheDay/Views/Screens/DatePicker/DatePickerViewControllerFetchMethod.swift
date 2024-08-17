//
//  DatePickerViewControllerFetchMethod.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 05.08.2024.
//

import UIKit

// MARK: - Fetch Information
extension DatePickerViewController {
    func fetchInformation(completion: @escaping () -> Void) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.isUserInteractionEnabled = false
        }
        
        DispatchQueue.main.async {
            self.showLoader()
        }
        
        let networkManager = NetworkManager()
        networkManager.fetchForDate(date: datePicker.date) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.information = response
                    self.translateInformation {
                        self.hideLoader()
                        completion()
                        
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            windowScene.windows.first?.isUserInteractionEnabled = true
                        }
                    }
                    
                case .failure:
                    AlertManager.presentAlert(on: self, title: NSLocalizedString("datePickerAlertTitle", comment: ""), message: NSLocalizedString("datePickerAlertMessage", comment: ""), okButtonTitle: "OK")
                    self.information = Constants.emptyString
                    self.image = Constants.emptyImage
                    self.hideLoader()
                    completion()
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        windowScene.windows.first?.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
}

// MARK: - Translate Information
extension DatePickerViewController {
    func translateInformation(completion: @escaping () -> Void) {
        let textToTranslate = self.information ?? Constants.emptyString
        let targetLanguage = "ru"
        
        let networkManager = NetworkManager()
        networkManager.translateText(text: textToTranslate, targetLanguage: targetLanguage) { translationResult in
            DispatchQueue.main.async {
                switch translationResult {
                case .success(let translatedText):
                    self.information = translatedText
                    self.fetchImage(networkManager: networkManager, completion: completion)
                    
                case .failure(let error):
                    self.image = Constants.emptyImage
                    completion()
                }
            }
        }
    }
}

// MARK: - Fetch Image
extension DatePickerViewController {
    func fetchImage(networkManager: NetworkManager, completion: @escaping () -> Void) {
        networkManager.fetchFirstImage(keyword: self.information ?? Constants.emptyString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.image = image
                    
                case .failure:
                    self.image = Constants.emptyImage
                }
                completion()
            }
        }
    }
}
