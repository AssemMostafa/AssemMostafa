//
//  CurrencyDetailsViewModel.swift
//  PriceCharts
//
//  Created by Assem on 16/07/2022.
//

import Foundation

 protocol CurrencyDetailsViewModelDelegate: AnyObject {
    func currencyDetailsListSuccessfully(currencyDetailsViewModels: [ChartDataPair])
    func didFailToGetCurrencyDetailsInfo(error: String)
}

 class CurrencyDetailsViewModel {
     // MARK: - Properties

     weak var delegate: CurrencyDetailsViewModelDelegate?
     
     // MARK: - WebServicse Functions

     func getCurrencyDetailsInfoWith(type: String, interval: String, limit: String) {
        let request = CandleStickRequests.getCandleSticks(symbol: type, interval: interval, limit: limit)
        NetworkRouter.sharedUtilityQos.request(request: request) { [weak self] (response) in
            guard let strongSelf = self else {
                return
            }
            switch response {
            case .success(let data):
                   let  baseDictionary = data.toDictionary()
                    let finalDict = baseDictionary.values.map({ element in
                        element as? Array<Any>
                    }).map { (model) -> CandelsModel in
                        var dict : CandelsModel = CandelsModel()
                        var high = ""
                        var low = ""
                        var openTime = 0
                        var closeTime = 0
                        var open = ""
                        var close = ""
                        if let finalModel = model {
                            for (index,item) in finalModel.enumerated() {
                                if index == 0 {
                                    openTime = item as! Int
                                }
                                if index == 6 {
                                    closeTime = item as! Int
                                }
                                if index == 1 {
                                    open = item as! String
                                }
                                if index == 2 {
                                    high = item as! String
                                }
                                if index == 3 {
                                    low = item as! String
                                }
                                if index == 4 {
                                    close = item as! String
                                }
                            }
                            dict.openTime = openTime
                            dict.closeTime = closeTime
                            dict.high = high
                            dict.low = low
                            dict.open = open
                            dict.close = close
                        }
                        return dict
                    }
                    let finalCandelsList = HelperManger.sharedInstance.convertToFinalObject(inputArr: finalDict)
                    self?.delegate?.currencyDetailsListSuccessfully(currencyDetailsViewModels: finalCandelsList)
            case .failure(let error):
                let error  = strongSelf.getMessage(for: error)
                strongSelf.delegate?.didFailToGetCurrencyDetailsInfo(error: error)
            }
        }
    }
}

// MARK: Reporting methods
 extension CurrencyDetailsViewModel {
    func getMessage(for error: Error?) -> String {
        var errorMessage = ""
        guard let error = error else {
            return ""
        }
        switch error {
        case NetworkError.noConnection:
            errorMessage = "Please check your internet connection"
        case NetworkError.timeout:
            errorMessage = "It’s taking too long, please try again"
        default:
            errorMessage = "something went wrong, please try again"
        }
        return errorMessage
    }
}


