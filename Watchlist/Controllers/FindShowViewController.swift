//
//  FindShowViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 12/7/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit

class FindShowViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var showsScrollView: UIScrollView!
    @IBOutlet weak var popularShowsView: UIView!
    @IBOutlet weak var topRatedShowsView: UIView!
    @IBOutlet weak var searchShowsView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    
    let width = UIScreen.main.bounds.width
    
    let popularPoint = CGPoint( x: 0, y: 0)
    var topRatedPoint: CGPoint {
        return CGPoint(x: width, y: 0)
    }
    var searchPoint: CGPoint {
        return CGPoint(x: width*2, y: 0)
    }
    
    var selectedView: UIView! {
        didSet {
            switch selectedView {
            case popularShowsView:
                showsScrollView.setContentOffset(popularPoint, animated: true)
                UIView.animate(withDuration: 0.25) {
                    self.indicatorView.center.x = self.popularShowsView.center.x
                }
                print("POPULAR TAPPED, CONTENT OFFSET:", showsScrollView.contentOffset)
            case topRatedShowsView:
                showsScrollView.setContentOffset(topRatedPoint, animated: true)
                UIView.animate(withDuration: 0.25) {
                    self.indicatorView.center.x = self.topRatedShowsView.center.x
                }
                print("TOP RATED TAPPED, CONTENT OFFSET:", showsScrollView.contentOffset)
            case searchShowsView:
                showsScrollView.setContentOffset(searchPoint, animated: true)
                UIView.animate(withDuration: 0.25) {
                    self.indicatorView.center.x = self.searchShowsView.center.x
                }
                print("SEARCH TAPPED, CONTENT OFFSET:", showsScrollView.contentOffset)
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showsScrollView.delegate = self
        
        selectedView = popularShowsView
        
        let popularTap = UITapGestureRecognizer(target: self, action: #selector(popularShowsTapped))
        let topRatedTap = UITapGestureRecognizer(target: self, action: #selector(topRatedShowsTapped))
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(searchShowsTapped))
        
        popularShowsView.addGestureRecognizer(popularTap)
        topRatedShowsView.addGestureRecognizer(topRatedTap)
        searchShowsView.addGestureRecognizer(searchTap)

    }
    
    @objc func popularShowsTapped() {
        selectedView = popularShowsView
    }
    
    @objc func topRatedShowsTapped() {
        selectedView = topRatedShowsView
    }
    
    @objc func searchShowsTapped() {
        selectedView = searchShowsView
    }
    
    func updateIndicatorView(point: CGPoint) {
        switch point {
        case popularPoint:
            UIView.animate(withDuration: 0.25) {
                self.indicatorView.center.x = self.popularShowsView.center.x
            }
        case topRatedPoint:
            UIView.animate(withDuration: 0.25) {
                self.indicatorView.center.x = self.topRatedShowsView.center.x
            }
        case searchPoint:
            UIView.animate(withDuration: 0.25) {
                self.indicatorView.center.x = self.searchShowsView.center.x
            }
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateIndicatorView(point: scrollView.contentOffset)
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
