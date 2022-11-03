//
//  NetworkManger.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import Foundation
import Alamofire

final class NetworkManger<T: Codable> {
    static func fetch(from url: String, completion: @escaping (Result<T, NetworkError> ) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { resp in
            debugPrint(resp)
            if resp.error != nil {
                completion(.failure(.invalidResponse))
                print(resp.error as Any)
                return
            }
            if let response = resp.value {
                completion(.success(response))
                return
            }
        }
    }
}
enum NetworkError: Error{
    case invalidResponse
    case nilResponse
}
