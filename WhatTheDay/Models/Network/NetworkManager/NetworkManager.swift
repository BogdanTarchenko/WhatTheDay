//
//  NetworkManager.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 04.08.2024.
//

import Foundation
import UIKit

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
        
        if case let .post(request) = api.method {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(request)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("Api-Key \(APIKeys.yandexAPIKey)", forHTTPHeaderField: "Authorization")
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }
        
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
