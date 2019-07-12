//
//  SignUp.swift
//  Box
//
//  Created by Jun Seub Lim on 10/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation
import Alamofire

struct SignUp {
    static let shared = SignUp()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func signUp(_ email: String,_ password: String,_ name: String,_ birth: String,_ phone :  String,_ gender :  String,_ receiver : String,_ receiver_phone: String,_ address1: String, _ address2: String,_ address_detail: String,_ delivery_memo: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let body : Parameters = [
            "email": email,
            "password": password,
            "name": name,
            "birth": birth,
            "phone": phone,
            "gender": gender,
            "receiver": receiver,
            "receiver_phone": receiver_phone,
            "address1": address1,
            "address2": address2,
            "address_detail": address_detail,
            "delivery_memo": delivery_memo
            ]
        
        Alamofire.request(APIConstants.SignUpURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData {
            response in
            print("#####Response#####")
            print(response)
            switch response.result {
            case .success:
                if let value = response.result.value {
                    print("#####Value#####")
                    print(value)
                    if let status = response.response?.statusCode
                    {
                        print("#####Status#####")
                        print(status)
                        switch status {
                            
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(ResponseSign.self, from: value)
                                switch result.success {
                                case true:
                                    print("case true")
                                    completion(.success(result.message))
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
                            print(status)
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
