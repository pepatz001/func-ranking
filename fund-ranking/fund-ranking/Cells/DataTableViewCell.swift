//
//  DataTableViewCell.swift
//  fund-ranking
//
//  Created by sira.lownoppakul on 14/12/2564 BE.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var navReturnLabel: UILabel!
    @IBOutlet weak var navLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupData(_ data: FundRanking) {
        nameLabel.text = data.fundCode
        navReturnLabel.text = "\(data.navReturn)"
        navLabel.text = "\(data.nav)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: data.date)
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd MMM yyyy"
        displayFormatter.locale = Locale(identifier: "th")
        dateLabel.text = "อัพเดตล่าสุด: \(displayFormatter.string(from: date ?? Date()))"
    }
}
