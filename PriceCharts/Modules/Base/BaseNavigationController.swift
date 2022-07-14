//
//  BaseNavigationController.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit
//
///// This is a class created for Base Navigation in Project
//

public class BaseNavigationController: UINavigationController {

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

    }
    public convenience init(rootViewController: UIViewController, shouldShowDefaultButtons: Bool) {
        self.init(rootViewController: rootViewController)
        if shouldShowDefaultButtons {
                self.setupBarButtons(on: rootViewController)
        }
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

   public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension UINavigationController: UITextFieldDelegate {

    public func pushViewController(_ viewController: UIViewController, animated: Bool, addDefaultButtons: Bool) {
        self.pushViewController(viewController, animated: true)
        if addDefaultButtons {
            setupBarButtons(on: viewController)
        }
    }

     func setupBarButtons(on viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barTintColor = .white
        viewController.navigationController?.view.backgroundColor = .white
        viewController.navigationController?.navigationBar.tintColor = .white
    }

}
