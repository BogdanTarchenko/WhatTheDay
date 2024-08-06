//
//  TranslateRequest.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 05.08.2024.
//

import Foundation

struct TranslateRequest: Encodable {
    let texts: [String]
    let targetLanguageCode: String
    
    init(text: String, targetLanguage: String) {
        self.texts = [text]
        self.targetLanguageCode = targetLanguage
    }
}
