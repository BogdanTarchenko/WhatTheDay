//
//  Alert.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 17.08.2024.
//

import UIKit

class AlertManager {
    
    static func presentAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        okButtonTitle: String,
        okActionHandler: ((UIAlertAction) -> Void)? = nil
    ){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: okActionHandler)
        
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true)
    }
}
