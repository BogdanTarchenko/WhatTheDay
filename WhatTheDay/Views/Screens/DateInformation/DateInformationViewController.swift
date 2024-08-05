//
//  DateInformationViewController.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import UIKit

class DateInformationViewController: BaseViewController {
// MARK: - Init
    var image: UIImage
    var information: String
    
    init(information: String, image: UIImage) {
        self.information = information
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        self.view.addSubview(informationImage)
        self.configureInformationImage()
        
        self.view.addSubview(informationLabel)
        self.configureInformationLabel()
    }
}
