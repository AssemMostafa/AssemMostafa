//
//  NetworkResponse.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import Foundation
import Alamofire

/// The response from a method that can result in either a successful or failed state
typealias DataResponseType  = DataResponse<Any>

public enum NetworkResponse {
    case success(data: NSArray)
    case failure(NetworkError)

    init(_ dataResponse: DataResponseType) {

        guard dataResponse.error == nil else {
            self = .failure(NetworkError(dataResponse.error!))
            return
        }
        guard let response = dataResponse.response, response.hasSuccessStatusCode else {
            self = .failure(NetworkError(dataResponse.response!.statusCode))
            return
        }
        guard let data = dataResponse.data else {
            self = .failure(.parsingJSONError)
            return
        }
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data , options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            self = .success(data: jsonResult)
        } catch {
            print(error)
            self = .failure(.parsingJSONError)
            return
        }
    }

}
extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
