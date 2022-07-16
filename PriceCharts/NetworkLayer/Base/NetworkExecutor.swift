//
//  NetworkExecutor.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import Foundation
import Alamofire
//import SwiftyJSON

protocol ExcutorProtocol: AnyObject {
    typealias OnProgressCallback = (CFloat) -> ()

    func request(request: NetworkRequest,
                 complation: @escaping (NetworkResponse)->())

}


/// Used to connect to any JSON API that is modeled by an AlamofireEndpoint
final class NetworkRouter: ExcutorProtocol{

    /**
     Initialize a shared object with a DispatchQueue.global(qos: .userInitiated)
     - use this shared object in loading Api Request

     */
    public static var shared: NetworkRouter {
        let manger = NetworkRouter(queue: DispatchQueue.global(qos: .userInitiated))
        return manger
    }

    /**
     Initialize a shared object with a DispatchQueue.global(qos: .utility)
     - use this shared object in requesting api for user interacting actions
     - use for long runing tasks
     */
    public static var sharedUtilityQos: NetworkRouter {
        let manger = NetworkRouter(queue: DispatchQueue.global(qos: .utility))
        return manger
    }

    private var queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)
    private init(queue: DispatchQueue) {
        self.queue = queue
    }

    func request(request: NetworkRequest,
                 complation _complation: @escaping (NetworkResponse) -> ()) {
        let complation: (NetworkResponse)->() = { responce in
            switch responce {
            case .failure(_):
                    DispatchQueue.main.async { _complation(responce) }
            default:
                DispatchQueue.main.async { _complation(responce) }
            }
        }

        DispatchQueue.main.async {
            ApiSessionManager
                .sessionManager
                .request(request)
                .responseJSON
                { (responce) in
                    complation(NetworkResponse(responce))
            }
        }
    }

    public static func stopAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
                dataTasks.forEach { $0.cancel() }
                uploadTasks.forEach { $0.cancel() }
                downloadTasks.forEach { $0.cancel() }
            })

    }
}
