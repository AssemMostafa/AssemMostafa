//
//  CurrencyDetailsViewController.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import UIKit
import Charts

class CurrencyDetailsViewController: UIViewController {

    // MARK: Properties and outlets

    @IBOutlet weak var candlestickView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var pageTitle = ""
    var dataEntries: [ChartDataEntry] = []
    var candelsList = [ChartDataPair]()
    public var viewModel: CurrencyDetailsViewModel?


    lazy var candlestickVieww: CandleStickChartView = {
        let chartView = CandleStickChartView()
        chartView.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 30
        chartView.pinchZoomEnabled = true
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .horizontal
        chartView.legend.drawInside = true
        chartView.rightAxis.enabled = true
        chartView.leftAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.clipValuesToContentEnabled = true
        return chartView
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = pageTitle
        setupCandelsConstrainsWith(candelView: self.candlestickVieww, baseView: self.candlestickView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViewModel()
    }

    // MARK: - Helper Functions

    private func setupViewModel() {
        viewModel = CurrencyDetailsViewModel()
        viewModel?.delegate = self
        self.showLoader()
        let type = self.pageTitle + "USDT"
        self.viewModel?.getCurrencyDetailsInfoWith(type: type, interval: "30", limit: "100") // there are no inputs UI for interval and limits so they are static
    }

    func setupCandelsViewWith(financialData: [ChartDataPair]) {
        for chartData in financialData {
            let open = chartData.Open
            let close = chartData.Close
            let high = chartData.High
            let low = chartData.Low
            let datetime = chartData.DateTime
            let doubleTime = Double(datetime)
            guard let finalTime = doubleTime else {return}
            let time = HelperManger.sharedInstance.getDateFromTimeStamp(timeStamp: finalTime)
            let components = time.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
            let hours = components[0]
            let minutes = components[1]
            if let xPoint = Double("\(hours).\(minutes)") {
                let dataEntry = CandleChartDataEntry(x: xPoint, shadowH: high, shadowL: low, open: open, close: close)
                dataEntries.append(dataEntry)
            }
        }
        let sortedDataEntries = dataEntries.sorted {$0.x < $1.x}
        let chartDataSet = CandleChartDataSet(entries: sortedDataEntries, label: "")
        chartDataSet.axisDependency = .right
        chartDataSet.increasingColor = #colorLiteral(red: 0, green: 0.8196078431, blue: 1, alpha: 1)
        chartDataSet.decreasingColor = #colorLiteral(red: 1, green: 0.3568627451, blue: 0.3568627451, alpha: 1)
        chartDataSet.drawIconsEnabled = true
        chartDataSet.shadowWidth = 0.7
        chartDataSet.decreasingFilled = true
        chartDataSet.increasingFilled = true
        chartDataSet.shadowColorSameAsCandle = true
        chartDataSet.barSpace = 0.40
        chartDataSet.drawValuesEnabled = true

        let chartData = CandleChartData(dataSet: chartDataSet)
        candlestickVieww.data = chartData
        candlestickVieww.fitScreen()
    }

    func setupCandelsConstrainsWith(candelView: CandleStickChartView, baseView: UIView) {
        baseView.addSubview(candelView)
        candelView.translatesAutoresizingMaskIntoConstraints = false
        candelView.heightAnchor
            .constraint(equalTo: baseView.heightAnchor, multiplier: 1.0).isActive = true
        candelView.widthAnchor
            .constraint(equalTo: baseView.widthAnchor, multiplier: 1.0).isActive = true
        candelView.topAnchor
            .constraint(equalTo: baseView.topAnchor).isActive = true
        candelView.centerXAnchor
            .constraint(equalTo: baseView.centerXAnchor).isActive = true
    }

    // MARK: - Actions

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: CurrencyDetailsViewModel Delegate

extension CurrencyDetailsViewController: CurrencyDetailsViewModelDelegate {
    func currencyDetailsListSuccessfully(currencyDetailsViewModels: [ChartDataPair]) {
        DispatchQueue.main.async {
            self.hideLoader()
            if !currencyDetailsViewModels.isEmpty {
                self.setupCandelsViewWith(financialData: currencyDetailsViewModels)
            }
        }
    }

    func didFailToGetCurrencyDetailsInfo(error: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.showAlert(with: error)
        }
    }
}
