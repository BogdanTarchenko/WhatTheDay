//
//  BaseViewController.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController?.viewControllers.first != self {
            setupCustomBackButton()
        }
    }
}

// MARK: CustomBackButton setup methods
extension BaseViewController {
    private func setupCustomBackButton() {
        let customBackButton = UIButton(type: .custom)
        customBackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        customBackButton.tintColor = UIColor(named: "accentColor")
        customBackButton.addTarget(self, action: #selector(customBackButtonTapped), for: .touchUpInside)
        
        let customBackBarButtonItem = UIBarButtonItem(customView: customBackButton)
        navigationItem.leftBarButtonItem = customBackBarButtonItem
    }
    
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
