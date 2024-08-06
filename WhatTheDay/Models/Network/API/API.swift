//
//  API.swift
//  WhatTheDay
//
//  Created by Богдан Тарченко on 06.08.2024.
//

import Foundation

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
    case translate(text: String, targetLanguage: String, apiKey: String)
    
    var endpoint: String {
        switch self {
        case .date(let month, let day):             return "\(month)/\(day)/date"
        case .photo(let keyword, let accessKey):    return "search/photos?page=1&query=\(keyword)&client_id=\(accessKey)"
        case .translate:                            return "translate/v2/translate"
        }
    }
    
    var method: Method {
        switch self {
        case .date, .photo:                                     return .get
        case .translate(let text, let targetLanguage, _):       return .post(request: TranslateRequest(text: text, targetLanguage: targetLanguage))
        }
    }
    
    var baseURL: String {
        switch self {
        case .date:         return "http://numbersapi.com/"
        case .photo:        return "https://api.unsplash.com/"
        case .translate:    return "https://translate.api.cloud.yandex.net/"
        }
    }
}
