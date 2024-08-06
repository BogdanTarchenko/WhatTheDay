//
//  CustomError.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 06.08.2024.
//

import Foundation

// MARK: - Error
enum CustomError: Error {
    case urlNotValid
    case requestFailed
    case noData
    case decodingError
}
