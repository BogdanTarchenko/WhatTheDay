//
//  DateResponse.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import Foundation

struct DateResponse: Decodable {
    let text: String
    let found: Bool
    let number: CGFloat
    let type: String
    let date: String?
    let year: String?
}
