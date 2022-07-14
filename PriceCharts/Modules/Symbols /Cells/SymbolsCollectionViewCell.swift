//
//  SymbolsCollectionViewCell.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit

class SymbolsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func confic(viewModel: String) {

        self.typeLabel.text = viewModel
    }
}
