//
//  WatchlistDetailViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 1/9/19.
//  Copyright © 2019 TJ Carney. All rights reserved.
//

import UIKit

class WatchlistDetailViewController: UIViewController {
    
    var show: TVShow!
    var type: ShowType!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        Shows.guide().removeShow(id: show.id, from: type)
        updateWatchlist()
    }
    
    func updateWatchlist() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateWatchlist"), object: nil)
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
