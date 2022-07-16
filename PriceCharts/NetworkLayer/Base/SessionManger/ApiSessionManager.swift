//
//  ApiSessionManager.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import Foundation
import Alamofire

 class ApiSessionManager: NSObject {

    private static var manager: SessionManager?

    public static var sessionManager : SessionManager {
            get {
                if manager == nil {
                    manager = SessionManager()
                }
                return manager!
            }
        }


    private override init() {
        super.init()
    }
    /// Use for update the header to contain token
    /// Use this func after every Login (after success validation with the server)
    static func cancelAllRequests() {
        manager = nil
        // it will automaticaly invalidateAndCancel()
    }

    deinit {
        ApiSessionManager.cancelAllRequests()
    }
}


 class AccessTokenAdapter: RequestAdapter {
    private let token: String?

    init(token: String?) {
        self.token = token
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Environment.shared.getBackendUrl().absoluteString) else {
            return urlRequest
        }
        return urlRequest
    }
}
