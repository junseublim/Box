//
//  GetForUDetail.swift
//  Box
//
//  Created by Jun Seub Lim on 10/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//
/*
import Foundation
import Alamofire

struct GetForU {
    static let shared = GetForU()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getForU(_ first: String,_ second: String,_ fifth: String,_ minprice: Int,_ minprice: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let tempUrl = APIConstants.ForUURL
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
                                let result = try decoder.decode(ResponseObject<PackageDetail<ProductInPackage>>.self, from: value)
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
*/
