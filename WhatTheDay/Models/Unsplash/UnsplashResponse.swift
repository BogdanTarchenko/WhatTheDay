//
//  UnsplashResponse.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 05.08.2024.
//

import Foundation

struct UnsplashResponse: Decodable {
    let results: [UnsplashPhoto]
}
