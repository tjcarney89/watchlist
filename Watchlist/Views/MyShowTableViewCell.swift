//
//  MyShowTableViewCell.swift
//  Watchlist
//
//  Created by TJ Carney on 11/28/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit

class MyShowTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var lastEpisodeLabel: UILabel!
    @IBOutlet weak var nextEpisodeLabel: UILabel!
    @IBOutlet weak var lastEpisodeDate: UILabel!
    
    @IBOutlet weak var nextEpisodeDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 0.75
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowRadius = 5.0
        
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = true
    }

   
}
