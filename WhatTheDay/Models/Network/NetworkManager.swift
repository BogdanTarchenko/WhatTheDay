//
//  NetworkManager.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import Foundation

// MARK: - Error
enum CustomError: Error {
    case urlNotValid
    case requestFailed
    case noData
    case decodingError
}

enum Api {
    enum Method {
        case get
        case post(request: Encodable)
        case put(request: Encodable)
    
        var rawValue: String {
            switch self {
            case .get:      return "GET"
            case .post:     return "POST"
            case .put:      return "PUT"
            }
        }
    }
    
    case date(month: Int, day: Int)
    
    var endpoint: String {
        switch self {
        case .date(let month, let day):     return "\(month)/\(day)/date"
        }
    }
    
    var method: Method {
        switch self {
        case .date:     return .get
        }
    }
    
    var baseURL: String {
        switch self {
        case .date:     return "http://numbersapi.com/"
        }
    }
}

final class NetworkManager {
    func fetch<T: Decodable>(api: Api, resultType: T.Type, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        let urlString = api.baseURL + api.endpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlNotValid))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func fetchForDate<T: Decodable>(date: Date, resultType: T.Type, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let api = Api.date(month: month, day: day)
        fetch(api: api, resultType: T.self, completion: completion)
    }
}
