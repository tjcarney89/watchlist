//
//  EpisodeCollectionViewCell.swift
//  Watchlist
//
//  Created by TJ Carney on 10/7/19.
//  Copyright © 2019 TJ Carney. All rights reserved.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        episodeImageView.layer.cornerRadius = 25
    }
    
}
