//
//  ViewController.swift
//  fund-ranking
//
//  Created by sira.lownoppakul on 14/12/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    private let apiUrl: String = "https://storage.googleapis.com/finno-ex-re-v2-static-staging/recruitment-test/fund-ranking-%@.json"
    private let timeFrames: [String] = [
        "1D", "1W", "1M", "1Y"
    ]
    
    private var fundRankings: [FundRanking] = []
    private var selectedTimeFrameIndex: Int = 0

    // MARK: - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
        
        if let initialTimeFrame = timeFrames.first {
            getFundRanking(initialTimeFrame)
        }
    }

    // MARK: - Setup
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Call API
extension ViewController {
    private func getFundRanking(_ timeFrame: String) {
        fundRankings = []
        tableView.reloadData()
        
        let pathUrl = String(format: apiUrl, timeFrame)
        guard let url = URL(string: pathUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(FundRankingResponse.self, from: data)
                    self.fundRankings = response.data

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}

// MARK: - Collection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        timeFrames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeFrameCollectionViewCell",
                                                            for: indexPath) as? TimeFrameCollectionViewCell else {
            return TimeFrameCollectionViewCell()
        }

        cell.setupData(timeFrames[indexPath.row], didSelected: selectedTimeFrameIndex == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTimeFrameIndex = indexPath.row
        collectionView.reloadData()
        getFundRanking(timeFrames[selectedTimeFrameIndex])
    }
}

// MARK: - Table View
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fundRankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell",
                                                       for: indexPath) as? DataTableViewCell else {
            return DataTableViewCell()
        }
        
        cell.setupData(fundRankings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderCellView.fromNib()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}

// MARK: - Model
struct FundRanking: Codable {
    var mstarID: String
    var fundCode: String
    var date: String
    var navReturn: Double
    var nav: Double
    var avgReturn: Double
    
    enum CodingKeys: String, CodingKey {
        case mstarID = "mstar_id"
        case fundCode = "thailand_fund_code"
        case date = "nav_date"
        case navReturn = "nav_return"
        case nav
        case avgReturn = "avg_return"
    }
}

struct FundRankingResponse: Codable {
    var status: Bool
    var error: String?
    var data: [FundRanking]
}
