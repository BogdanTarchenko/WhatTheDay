//
//  NetworkManagerUnsplash.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 06.08.2024.
//

import Foundation
import UIKit

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
