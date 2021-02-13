//
//  APIConstants.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/08.
//

import Foundation

struct APIConstants {
    // 기본 url
    static let baseURL = "https://api.unsplash.com"
    
    // api-1: 사진 검색
    static let searchPhotosURL = baseURL + "/search/photos?client_id={client_id}&query={query}&page={page}"
    
    // api-2: 사용자 공개 프로필
    static let userProfileURL = baseURL + "/users/:username?client_id={client_id}"
    
    
}
