//
//  SymbolsListViewController.swift
//  PriceCharts
//
//  Created by Assem on 12/07/2022.
//

import UIKit

class SymbolsListViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var symbolsCollectionView: UICollectionView!
//    let viewModel = LeaguesViewModel()
    var symbolsList = [String]()
    @IBOutlet weak var symbolsCollectionViewHeight: NSLayoutConstraint!


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
     func setupView() {
         symbolsList = ["BTC", "ETH", "LTC"]
         setupSymbolsCollectionView()
         self.symbolsCollectionView.reloadData()
    }

}
// MARK: CollectionView DataSource and Delegate

extension SymbolsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        symbolsCollectionViewHeight.constant = self.symbolsCollectionView.contentSize.height

    }
    fileprivate func setupSymbolsCollectionView() {
        self.symbolsCollectionView.delegate = self
        self.symbolsCollectionView.dataSource = self
        let cellIdentfier = String(describing: SymbolsCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentfier, bundle: nil)
        symbolsCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentfier)
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
//        let viewModel = self.leagesList[indexPath.item]
//        if let id = viewModel.id, let name = viewModel.name, let des = viewModel.area?.name, let currentMatch = viewModel.currentSeason?.currentMatchday, let numOfMatch = viewModel.numberOfAvailableSeasons {
//            self.navigateToTeamsVC(leagueId: id, leagueName: name, leagueDesc: des, currentMatchday: currentMatch, numberOfAvailableSeasons: numOfMatch, leagueImage: viewModel.emblemUrl ?? "")
        }
    }

