//
//  PopularShowsViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 12/4/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit

class PopularShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var popularShowsTableView: UITableView!
    
    var popularShows: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularShowsTableView.delegate = self
        popularShowsTableView.dataSource = self
        
        TVAPIClient.fetchPopularShows(page: 1) { (shows) in
            self.popularShows = shows
            DispatchQueue.main.async {
                self.popularShowsTableView.reloadData()
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularShows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popularShowsTableView.dequeueReusableCell(withIdentifier: "popularShowCell", for: indexPath) as! SearchResultTableViewCell
        cell.nameLabel.text = popularShows[indexPath.row].title
        let url = URL(string: baseImageURL + popularShows[indexPath.row].imagePath)
        cell.searchResultImageView.kf.setImage(with: url)
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ShowDetailViewController {
            let show = popularShows[(popularShowsTableView.indexPathForSelectedRow?.row)!]
            TVAPIClient.fetchShowDetails(showID: show.id) { (show) in
                detailVC.show = show
            }
        }
        
    }
    

}
