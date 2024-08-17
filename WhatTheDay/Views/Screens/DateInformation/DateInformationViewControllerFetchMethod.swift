//
//  DateInformationViewControllerFetchMethod.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 17.08.2024.
//

import UIKit

// MARK: - Fetch Languages
extension DateInformationViewController {
    func fetchLanguages() {
        
        let networkManager = NetworkManager()
        networkManager.getLanguagesList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let languages):
                    self?.languages = languages
                    self?.languagePicker.reloadAllComponents()
                    
                    if let defaultIndex = self?.languages.firstIndex(where: { $0.code == Constants.defaultLanguageCode }) {
                        self?.languagePicker.selectRow(defaultIndex, inComponent: 0, animated: false)
                    }
                    
                case .failure(let error):
                    if let viewController = self {
                        AlertManager.presentAlert(on: viewController, title: NSLocalizedString("fetchLanguagesAlertTitle", comment: ""), message: NSLocalizedString("fetchLanguagesAlertMessage", comment: ""), okButtonTitle: "OK")
                    }
                    self?.languages = []
                }
            }
        }
    }
}

// MARK: - ReTranslate Information
extension DateInformationViewController {
    func translateInformation(to targetLanguage: String, completion: @escaping () -> Void) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.isUserInteractionEnabled = false
        }
        
        DispatchQueue.main.async {
            self.showLoader()
        }
        
        let textToTranslate = self.information ?? Constants.emptyString
        
        let networkManager = NetworkManager()
        networkManager.translateText(text: textToTranslate, targetLanguage: targetLanguage) { translationResult in
            DispatchQueue.main.async {
                switch translationResult {
                case .success(let translatedText):
                    self.information = translatedText
                    
                case .failure(let error):
                    AlertManager.presentAlert(on: self, title: NSLocalizedString("dateInformationAlertTitle", comment: ""), message: NSLocalizedString("dateInformationAlertMessage", comment: ""), okButtonTitle: "OK")
                    self.information = nil
                    self.image = Constants.emptyImage
                }
                self.hideLoader()
                completion()
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.first?.isUserInteractionEnabled = true
                }
            }
        }
    }
}
