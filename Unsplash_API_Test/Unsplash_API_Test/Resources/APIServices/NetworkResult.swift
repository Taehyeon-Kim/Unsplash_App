//
//  NetworkResult.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/08.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
