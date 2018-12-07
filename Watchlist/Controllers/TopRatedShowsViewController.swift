//
//  TopRatedShowsViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 12/7/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit

class TopRatedShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topRatedShowsTableView: UITableView!
    
    var topRatedShows: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRatedShowsTableView.delegate = self
        topRatedShowsTableView.dataSource = self
        
        TVAPIClient.fetchTopRatedShows(page: 1) { (shows) in
            self.topRatedShows = shows
            DispatchQueue.main.async {
                self.topRatedShowsTableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topRatedShows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topRatedShowsTableView.dequeueReusableCell(withIdentifier: "topRatedShowCell", for: indexPath) as! SearchResultTableViewCell
        cell.nameLabel.text = topRatedShows[indexPath.row].title
        let url = URL(string: baseImageURL + topRatedShows[indexPath.row].imagePath)
        cell.searchResultImageView.kf.setImage(with: url)
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ShowDetailViewController {
            let show = topRatedShows[(topRatedShowsTableView.indexPathForSelectedRow?.row)!]
            TVAPIClient.fetchShowDetails(showID: show.id) { (show) in
                detailVC.show = show
            }
        }
        
    }
    
    
}

