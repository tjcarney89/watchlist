//
//  ShowDetailViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 12/6/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit
import Kingfisher

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    
    var show: TVShow! {
        didSet {
            nameLabel.text = show.name
            overviewLabel.text = show.overview
            statusLabel.text = show.status
            let url = URL(string: baseImageURL + show.imagePath)
            showImageView.kf.setImage(with: url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
