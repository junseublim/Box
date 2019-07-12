//
//  GetSearchList.swift
//  Box
//
//  Created by Jun Seub Lim on 12/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//
import Foundation
import Alamofire

struct GetSearchList {
    static let shared = GetSearchList()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getSearchList(_ search: String, _ flag: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        //  http://13.209.206.99:3000/api/product/regular?category=%EC%83%9D%EC%88%98/%EC%9D%8C%EB%A3%8C&flag=1
        let tempUrl = APIConstants.RegularProductURL + "?search=\(search)&flag=\(flag)"
        let url: URL = URL(string: tempUrl.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData {
            response in
            print("#####Response#####")
            print(response)
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode
                    {
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(ResponseObject<ResponseRegular<Regular>>.self, from: value)
                                switch result.success {
                                case true:
                                    print("case true")
                                    completion(.success(result.data))
                                case false:
                                    print("case false")
                                    completion(.requestErr(result.message))
                                }
                            } catch {
                                print("do catch")
                                completion(.pathErr)
                            }
                        case 400:
                            completion(.pathErr)
                        case 500:
                            completion(.serverErr)
                            
                        default:
                            break
                        }
                    }
                }
            case .failure(_):
                print("failure")
                break
            }
        }
    }
}

