//
//  UIViewController.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit

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


