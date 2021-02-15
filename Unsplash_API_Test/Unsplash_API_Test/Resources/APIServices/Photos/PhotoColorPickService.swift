//
//  PhotoColorPickService.swift
//  Unsplash_API_Test
//
//  Created by taehy.k on 2021/02/15.
//

import Foundation

import Alamofire

struct PhotoColorPickService {
    static let shared = PhotoColorPickService()
    
    func makeURL(image_url: String) -> String {
        var url = APIConstants.pickColorURL
        url = url.replacingOccurrences(of: "{image_url}", with: image_url)
        return url
    }
    
    func getPhotoColor(image_url: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = makeURL(image_url: image_url)
        let headers: HTTPHeaders = ["Authorization" : "Basic YWNjX2M3MzQ4ZTA1ODEwM2Y4YjpkMzFiODk1YTgzNTdkODhkMDg2NmIwZjA0ZTdhZmQzYg=="]
        let dataRequest = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)

        dataRequest.responseData{ (response) in
            switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else{
                        return
                    }
                    guard let data = response.value else{
                        return
                    }

                    completion(judgePhotoColor(status: statusCode, data: data, url: url))
                case .failure(let err):
                    print(err)
                    completion(.networkFail)
            }
        }
    }
    
    private func judgePhotoColor(status: Int, data: Data, url: String) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ColorResponse.self, from: data) else{
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
