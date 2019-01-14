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
    @IBOutlet weak var addToCurrentButton: UIButton!
    @IBOutlet weak var addToUpcomingButton: UIButton!
    @IBOutlet weak var addToCompletedButton: UIButton!
    @IBOutlet weak var addToDiscoverButton: UIButton!
    
    var show: TVShow! {
        didSet {
            nameLabel.text = show.name
            overviewLabel.text = show.overview
            statusLabel.text = show.status
            let url = URL(string: baseImageURL + show.imagePath)
            showImageView.kf.setImage(with: url)
            
            if show.showType != nil {
                if show.showType == ShowType.discover {
                    addToDiscoverButton.isHidden = true
                } else {
                    self.hideButtons()
                }
            }
        }
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func hideButtons() {
        addToCurrentButton.isHidden = true
        addToUpcomingButton.isHidden = true
        addToCompletedButton.isHidden = true
        addToDiscoverButton.isHidden = true
    }
    
    
    @IBAction func addToCurrentTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .current)
        showAlert(for: .current)
        checkDiscover()
        updateWatchlist()
        hideButtons()
    }
    
    @IBAction func addToUpcomingTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .upcoming)
        showAlert(for: .upcoming)
        checkDiscover()
        updateWatchlist()
        hideButtons()
        
    }
    
    @IBAction func addToCompletedTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .completed)
        showAlert(for: .completed)
        checkDiscover()
        updateWatchlist()
        hideButtons()
    }
    
    @IBAction func addToDiscoverTapped(_ sender: Any) {
        Shows.guide().addShow(id: show.id, to: .discover)
        showAlert(for: .discover)
        updateDiscover()
        hideButtons()
    }
    
    func checkDiscover() {
        if show.showType == ShowType.discover {
            Shows.guide().removeShow(id: show.id, from: .discover)
            updateDiscover()
        }
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateWatchlist"), object: nil)
    }
    
    func updateDiscover() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateDiscover"), object: nil)
    }
    
    
}
