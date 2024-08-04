//
//  DateInformationViewController.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit

class DateInformationViewController: BaseViewController {
// MARK: - Init
    var informationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(informationLabel)
        self.configureInformationLabel()
    }
}
