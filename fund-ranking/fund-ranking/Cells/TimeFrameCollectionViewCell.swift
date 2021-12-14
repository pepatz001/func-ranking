//
//  TimeFrameCollectionViewCell.swift
//  fund-ranking
//
//  Created by sira.lownoppakul on 14/12/2564 BE.
//

import UIKit

class TimeFrameCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setupData(_ data: String?, didSelected: Bool = false) {
        titleLabel.text = data
        titleLabel.textColor = didSelected ? .darkGray : .white
        containerView.backgroundColor = didSelected ? .systemYellow : .init(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
    }
}
