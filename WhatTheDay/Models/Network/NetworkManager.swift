//
//  NetworkManager.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import Foundation
import UIKit

// MARK: - Error
enum CustomError: Error {
    case urlNotValid
    case requestFailed
    case noData
    case decodingError
}

// MARK: - API
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
    case photo(keyword: String, accessKey: String)
    
    var endpoint: String {
        switch self {
        case .date(let month, let day):             return "\(month)/\(day)/date"
        case .photo(let keyword, let accessKey):    return "search/photos?page=1&query=\(keyword)&client_id=\(accessKey)"
        }
    }
    
    var method: Method {
        switch self {
        case .date, .photo:     return .get
        }
    }
    
    var baseURL: String {
        switch self {
        case .date:     return "http://numbersapi.com/"
        case .photo:    return "https://api.unsplash.com/"
        }
    }
}

// MARK: - Network Manager
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
            
            if let stringData = String(data: data, encoding: .utf8) as? T {
                completion(.success(stringData))
            } else {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
        task.resume()
    }
}

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

// MARK: - fetch function for Unsplash API
extension NetworkManager {
    func fetchFirstImage(keyword: String, completion: @escaping (Result<UIImage, CustomError>) -> Void) {
        let api = Api.photo(keyword: keyword, accessKey: APIKeys.unsplashAPIKey)
        fetch(api: api, resultType: UnsplashResponse.self) { result in
            switch result {
            case .success(let response):
                if let firstPhoto = response.results.first, let imageURL = URL(string: firstPhoto.urls.small) {
                    self.downloadImage(from: imageURL) { result in
                        switch result {
                        case .success(let image):
                            completion(.success(image))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Download image method
extension NetworkManager {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, CustomError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
}

// MARK: - API Keys
extension NetworkManager {
    enum APIKeys {
        static let unsplashAPIKey: String = "__znh41-xQU2ZapY_JVXs_ucxf0Ec85sERAf65EoFiA"
    }
}
