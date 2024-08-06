//
//  NetworkManagerYandex.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 06.08.2024.
//

import Foundation

// MARK: - fetch function for YandexAPI
extension NetworkManager {
    func translateText(text: String, targetLanguage: String, completion: @escaping (Result<String, CustomError>) -> Void) {
        
        let api = Api.translate(text: text, targetLanguage: targetLanguage, apiKey: APIKeys.yandexAPIKey)
        fetch(api: api, resultType: TranslateResponse.self) { result in
            switch result {
            case .success(let response):
                if let translatedText = response.translations.first?.text {
                    completion(.success(translatedText))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
