//
//  DatePickerViewControllerFetchMethod.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 05.08.2024.
//

import UIKit

// MARK: - Fetch method
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
                    networkManager.fetchFirstImage(keyword: self.information ?? Constants.emptyString) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let image):
                                self.image = image
                                completion()
                            case .failure(let error):
                                self.image = Constants.emptyImage
                                completion()
                            }
                        }
                    }
                case .failure(let error):
                    self.information = Constants.emptyString
                    self.image = Constants.emptyImage
                    completion()
                }
                self.hideLoader()
            }
        }
    }
}
