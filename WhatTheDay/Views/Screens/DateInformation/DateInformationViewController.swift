//
//  DateInformationViewController.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit

class DateInformationViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Init
    var image: UIImage?
    var information: String?
    var languages: [Language] = []
    var loader: UIActivityIndicatorView?
    
    init(information: String, image: UIImage) {
        self.information = information
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.information = Constants.emptyString
        self.image = Constants.emptyImage
        super.init(coder: coder)
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var languagePicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    var informationImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var informationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.fetchLanguages()
        
        self.view.addSubview(scrollView)
        self.configureScrollView()
        
        scrollView.addSubview(contentView)
        self.configureContentView()
        
        contentView.addSubview(informationImage)
        self.configureInformationImage()
        
        contentView.addSubview(informationLabel)
        self.configureInformationLabel()
        
        contentView.addSubview(languagePicker)
        self.configureLanguagePicker()
    }
}
