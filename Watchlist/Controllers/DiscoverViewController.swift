//
//  DiscoverViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 1/7/19.
//  Copyright © 2019 TJ Carney. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var discoverTableView: UITableView!
    
    var discoverShows: [TVShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.discoverTableView.delegate = self
        self.discoverTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateShows), name: NSNotification.Name(rawValue: "UpdateDiscover"), object: nil)
        
        self.fetchDiscoverShows()
        
        
    }
    
    func fetchDiscoverShows() {
        if let showIDs = Shows.guide().allShows["discover"] {
            Shows.guide().fetchShows(for: .discover, ids: showIDs) { (discoverShows) in
                self.discoverShows = discoverShows
                DispatchQueue.main.async {
                    self.discoverTableView.reloadData()
                }
            }
        }
    }
    
    @objc func updateShows() {
        self.fetchDiscoverShows()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoverShows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoverTableView.dequeueReusableCell(withIdentifier: "discoverCell", for: indexPath) as! DiscoverTableViewCell
        let currentShow = discoverShows[indexPath.row]
        
        cell.showNameLabel.text = currentShow.name
        
        let url = URL(string: baseImageURL + currentShow.imagePath)
        cell.showImageView.kf.setImage(with: url)
        
        return cell 
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
