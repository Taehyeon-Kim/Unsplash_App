//
//  PhotoSearchService.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/08.
//

import Foundation

import Alamofire

struct PhotoSearchService {
    static let shared = PhotoSearchService()
    
    func makeURL(clientID: String, query: String, page: Int) -> String {
        var url = APIConstants.searchPhotosURL
        url = url.replacingOccurrences(of: "{client_id}", with: clientID)
        url = url.replacingOccurrences(of: "{query}", with: query)
        url = url.replacingOccurrences(of: "{page}", with: String(page))
        return url
    }
    
    func getSearchPhoto(clientID: String, query: String, page: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = makeURL(clientID: clientID, query: query, page: page)
        let dataRequest = AF.request(url, method: .get, encoding: JSONEncoding.default)
        print(dataRequest)
        dataRequest.responseData{ (response) in
            switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else{
                        return
                    }
                    guard let data = response.value else{
                        return
                    }
                    completion(judgeSearchPhoto(status: statusCode, data: data, url: url))
                case .failure(let err):
                    print(err)
                    completion(.networkFail)
            }
        }
    }
    
    private func judgeSearchPhoto(status: Int, data: Data, url: String) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(PhotoSearchResponse.self, from: data) else{
            return .pathErr
        }
        switch status{
            case 200:
                return .success(decodedData)
            case 400..<500:
                return .requestErr(decodedData)
            case 500:
                return .serverErr
            default:
                return .networkFail
        }
    }
}
