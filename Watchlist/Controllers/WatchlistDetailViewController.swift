//
//  WatchlistDetailViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 1/9/19.
//  Copyright © 2019 TJ Carney. All rights reserved.
//

import UIKit



class WatchlistDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var showStatusLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    
    var show: TVShow!
    var type: ShowType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
        
        containerView.layer.cornerRadius = 35
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let url = URL(string: baseImageURL + show.imagePath)
        showImageView.kf.setImage(with: url)
        nameLabel.text = show.name
        networkLabel.text = show.networks.joined(separator: ", ")
        seasonsLabel.text = pluralize(seasons: show.seasons)
        showStatusLabel.text = "   \(show.status)   "
        showStatusLabel.layer.cornerRadius = showStatusLabel.frame.height/2
        showStatusLabel.layer.masksToBounds = true
        changeStatusColor()
        overviewTextView.text = show.overview
        removeButton.layer.cornerRadius = removeButton.frame.height/2
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    func pluralize(seasons: Int) -> String {
        if seasons == 1 {
            return "1 Season"
        } else {
            return "\(seasons) Seasons"
        }
    }
    
    func changeStatusColor() {
        if show.status == "Returning Series" {
            showStatusLabel.backgroundColor = WatchlistColors.green
        } else if show.status == "Ended" {
            showStatusLabel.backgroundColor = .red
        } else {
            showStatusLabel.backgroundColor = .yellow
        }
    }
    
    //MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodeCell", for: indexPath) as! EpisodeCollectionViewCell
        
        let url = URL(string: baseImageURL + show.lastEpisode.imagePath)
        print("EPISODE URL: " + baseURL + show.lastEpisode.imagePath)
        cell.episodeImageView.kf.setImage(with: url)
        cell.episodeNumberLabel.text = "S\(show.lastEpisode.seasonNumber), E\(show.lastEpisode.episodeNumber)"
        cell.episodeNameLabel.text = show.lastEpisode.name
        cell.episodeDateLabel.text = show.lastEpisode.date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: episodesCollectionView.frame.width, height: episodesCollectionView.frame.height)
    }
    
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        Shows.guide().removeShow(id: show.id, from: type)
        updateWatchlist()
    }
    
    func updateWatchlist() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateWatchlist"), object: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
