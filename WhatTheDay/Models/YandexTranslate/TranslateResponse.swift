//
//  TranslateResponse.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 05.08.2024.
//

import Foundation

struct TranslateResponse: Decodable {
    let translations: [Translation]
    
    struct Translation: Decodable {
        let text: String
    }
}
