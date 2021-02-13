//
//  UserInfoService.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/13.
//

import Foundation
import Alamofire

struct UserInfoService {
    static let shared = UserInfoService()
    
    func makeURL(clientID: String, username: String) -> String {
        var url = APIConstants.userProfileURL
        url = url.replacingOccurrences(of: "{client_id}", with: clientID)
        url = url.replacingOccurrences(of: ":username", with: username)
        return url
    }
    
    func getUserInfo(clientID: String, username: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = makeURL(clientID: clientID, username: username)
        if let encodeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            print(encodeURL)
            let dataRequest = AF.request(encodeURL, method: .get, encoding: JSONEncoding.default)
            dataRequest.responseData{ (response) in
                switch response.result{
                    case .success:
                        guard let statusCode = response.response?.statusCode else{
                            return
                        }
                        guard let data = response.value else{
                            return
                        }
                        print("☎️ \(data)")
                        completion(judgeUserInfo(status: statusCode, data: data, url: url))
                    case .failure(let err):
                        print(err)
                        completion(.networkFail)
                }
            }
        }

    }
    
    private func judgeUserInfo(status: Int, data: Data, url: String) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(UserResponse.self, from: data) else{
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
