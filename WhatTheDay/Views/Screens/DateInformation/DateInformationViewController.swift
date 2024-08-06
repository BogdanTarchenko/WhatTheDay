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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
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
        
        self.view.addSubview(scrollView)
        self.configureScrollView()
        
        scrollView.addSubview(contentView)
        self.configureContentView()
        
        contentView.addSubview(informationImage)
        self.configureInformationImage()
        
        contentView.addSubview(informationLabel)
        self.configureInformationLabel()
    }
}
