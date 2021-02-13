//
//  PhotoSearchData.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/08.
//
import Foundation

struct PhotoSearchResponse: Codable {
    var total: Int
    var total_pages: Int
    var results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}
