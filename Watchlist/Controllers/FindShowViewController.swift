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
    
    let width = UIScreen.main.bounds.width
    
    let popularPoint = CGPoint( x: 0, y: 0)
    var topRatedPoint: CGPoint {
        return CGPoint(x: width, y: 0)
    }
    var searchPoint: CGPoint {
        return CGPoint(x: width*2, y: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showsScrollView.delegate = self 

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
