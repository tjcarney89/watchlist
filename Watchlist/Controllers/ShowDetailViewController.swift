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
    
    
    @IBAction func addToCurrentTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .current)
        showAlert(for: .current)
        updateWatchlist()
    }
    
    @IBAction func addToUpcomingTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .upcoming)
        showAlert(for: .upcoming)
        updateWatchlist()
        
    }
    
    @IBAction func addToCompletedTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .completed)
        showAlert(for: .completed)
        updateWatchlist()
    }
    
    func showAlert(for list: ShowType) {
        let alert = UIAlertController.init(title: "Show Added", message: "\(self.show.name) added to \(list.rawValue.capitalized)", preferredStyle: .alert)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
                alert.view.alpha = 0
            }, completion: { (result) in
                alert.dismiss(animated: false, completion: nil)
            })
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateWatchlist() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateShows"), object: nil)
    }
    
    
}
