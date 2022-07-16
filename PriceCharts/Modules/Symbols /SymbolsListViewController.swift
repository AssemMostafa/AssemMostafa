//
//  SymbolsListViewController.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit

class SymbolsListViewController: UIViewController {

    // MARK: Properties and outlets
    @IBOutlet weak var symbolsCollectionView: UICollectionView!
    @IBOutlet weak var symbolsCollectionViewHeight: NSLayoutConstraint!
    var symbolsList = [String]()


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Helper Functions
    func setupView() {
        symbolsList = ["BTC", "ETH", "LTC"]
        setupSymbolsCollectionView()
        self.symbolsCollectionView.reloadData()
    }

    func navigateToCurrencyDetailsVC(type: String) {
        let vc = CurrencyDetailsViewController()
        vc.pageTitle = type
        self.navigationController?.pushViewController(vc, animated: true, addDefaultButtons: false)
    }
}

// MARK: CollectionView DataSource and Delegate

extension SymbolsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    fileprivate func setupSymbolsCollectionView() {
        self.symbolsCollectionView.delegate = self
        self.symbolsCollectionView.dataSource = self
        let cellIdentfier = String(describing: SymbolsCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentfier, bundle: nil)
        symbolsCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentfier)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        symbolsCollectionViewHeight.constant = self.symbolsCollectionView.contentSize.height

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView === self.symbolsCollectionView {
            return 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === self.symbolsCollectionView {
            return CGSize(width: collectionView.frame.size.width, height: 44)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.symbolsCollectionView {
            return symbolsList.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === self.symbolsCollectionView {
            if !self.symbolsList.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                String(describing: SymbolsCollectionViewCell.self),
                                                              for: indexPath) as! SymbolsCollectionViewCell

                let viewModel = self.symbolsList[indexPath.item]
                cell.confic(viewModel: viewModel)
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = self.symbolsList[indexPath.item]
        navigateToCurrencyDetailsVC(type: type)
    }
}


