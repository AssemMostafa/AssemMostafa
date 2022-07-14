//
//  ApplicationController.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit

public class ApplicationController {
    public var window: UIWindow
    let navBar = BaseNavigationController(rootViewController: SymbolsListViewController())

    public init(window: UIWindow) {
        self.window = window
    }

    public func loadInitialView() {
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = navBar
        window.makeKeyAndVisible()
    }
}
