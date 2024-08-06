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
        DispatchQueue.main.async {
            self.showLoader()
        }
        
        let networkManager = NetworkManager()
        networkManager.fetchForDate(date: datePicker.date) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.information = response
                    self.translateInformation(networkManager: networkManager, completion: completion)
                case .failure:
                    self.information = Constants.emptyString
                    self.image = Constants.emptyImage
                    completion()
                }
                self.hideLoader()
            }
        }
    }
}

// MARK: - Translate Information
extension DatePickerViewController {
    func translateInformation(networkManager: NetworkManager, completion: @escaping () -> Void) {
        let textToTranslate = self.information ?? Constants.emptyString
        let targetLanguage = "ru"
        
        networkManager.translateText(text: textToTranslate, targetLanguage: targetLanguage) { translationResult in
            DispatchQueue.main.async {
                switch translationResult {
                case .success(let translatedText):
                    self.fetchImage(networkManager: networkManager, completion: completion)
                    self.information = translatedText
                    print(translatedText)
                case .failure(let error):
                    print(error)
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
