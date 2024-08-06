//
//  NetworkManagerNumbers.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 06.08.2024.
//

import Foundation

// MARK: - fetch function for NumbersAPI
extension NetworkManager {
    func fetchForDate(date: Date, completion: @escaping (Result<String, CustomError>) -> Void) {
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let api = Api.date(month: month, day: day)
        fetch(api: api, resultType: String.self, completion: completion)
    }
}
