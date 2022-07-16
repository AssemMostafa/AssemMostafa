//
//  UIViewController.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit
import FTIndicator

extension UIViewController {

    func showAlert(with message: String, title: String? = nil, actionClosure: (() -> ())? = nil) {

       let alert = UIAlertController(title: title ?? "Error", message: message, preferredStyle: .alert)
       let dismissAction = UIAlertAction(title: "OK", style: .default) { _ in
           actionClosure?()
       }
       alert.addAction(dismissAction)
       self.present(alert, animated: true)
   }
}


extension UIViewController{
     func showLoader() {
        DispatchQueue.main.async {
            FTIndicator.showProgress(withMessage: "loading...", userInteractionEnable: false)
        }
    }

     func hideLoader() {
        DispatchQueue.main.async {
            FTIndicator.dismissProgress()
        }
    }

     func showAlertmessage(with message: String, title: String? = nil) {

        let alert = UIAlertController(title: title ?? "Error", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default) { _ in

        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    }

}
