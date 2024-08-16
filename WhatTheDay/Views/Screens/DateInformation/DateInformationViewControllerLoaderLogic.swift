//
//  DateInformationViewControllerLoaderLogic.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 17.08.2024.
//

import UIKit

// MARK: - Loader logic
extension DateInformationViewController {
    func showLoader() {
        self.view.backgroundColor = .systemGray
        self.view.layer.opacity = 0.5
        
        loader = UIActivityIndicatorView(style: .large)
        loader?.center = view.center
        loader?.color = .white
        loader?.startAnimating()
        
        if let loader = loader {
            view.addSubview(loader)
        }
    }
    
    func hideLoader() {
        self.view.backgroundColor = .systemBackground
        self.view.layer.opacity = 1
        
        loader?.stopAnimating()
        loader?.removeFromSuperview()
        loader = nil
    }
}

