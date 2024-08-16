//
//  LanguagesResponse.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 17.08.2024.
//

import Foundation

struct LanguagesResponse: Decodable {
    let languages: [Language]
}

struct Language: Decodable {
    let code: String?
    let name: String?
}
