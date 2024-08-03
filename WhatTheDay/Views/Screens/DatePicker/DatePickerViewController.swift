//
//  DatePickerViewController.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 03.08.2024.
//

import UIKit

class DatePickerViewController: UIViewController, CustomButtonDelegate {
// MARK: - Init
    var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var titleImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
    }()
    
    var button: CustomButton = {
        let button = CustomButton()
        return button
    }()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(titleImage)
        self.configureTitleImage()
        
        self.view.addSubview(titleLabel)
        self.configureTitleLabel()
        
        self.view.addSubview(datePicker)
        self.configureDatePicker()
        
        self.view.addSubview(button)
        button.delegate = self
        self.configureButton()
    }
}
