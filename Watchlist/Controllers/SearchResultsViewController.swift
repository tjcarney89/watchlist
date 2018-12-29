//
//  SearchResultsViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 11/21/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit
import Kingfisher

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchBar.delegate = self 

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)as! SearchResultTableViewCell
        cell.nameLabel.text = searchResults[indexPath.row].title
        let url = URL(string: baseImageURL + searchResults[indexPath.row].imagePath)
        cell.searchResultImageView.kf.setImage(with: url)
        return cell
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text!
        TVAPIClient.searchShow(query: query) { (results) in
            
            DispatchQueue.main.async {
                self.searchResults = results
                self.searchResultsTableView.reloadData()
            }
        }
        
        self.view.endEditing(true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ShowDetailViewController {
            let show = searchResults[(searchResultsTableView.indexPathForSelectedRow?.row)!]
            TVAPIClient.fetchShowDetails(showID: show.id) { (show) in
                detailVC.show = show
            }
        }
        
    }
 

}
