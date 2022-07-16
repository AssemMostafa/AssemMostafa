//
//  String.swift
//  PriceCharts
//
//  Created by Assem on 16/07/2022.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

extension NSArray {

    func toDictionary() -> [Int: Element] {
        self.enumerated().reduce(into: [Int: Element]()) { $0[$1.offset] = $1.element }
    }

}
