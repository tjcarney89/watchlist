//
//  ViewController.swift
//  Watchlist
//
//  Created by TJ Carney on 11/14/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var watchlistSegmentedControl: UISegmentedControl!
    @IBOutlet weak var watchlistScrollView: UIScrollView!
    @IBOutlet weak var currentShowsTableView: UITableView!
    @IBOutlet weak var upcomingShowsTableView: UITableView!
    @IBOutlet weak var completedShowsTableView: UITableView!
    
    let width = UIScreen.main.bounds.width
    
    let upcomingPoint = CGPoint( x: 0, y: 0)
    var currentPoint: CGPoint {
        return CGPoint(x: width, y: 0)
    }
    var completedPoint: CGPoint {
        return CGPoint(x: width*2, y: 0)
    }
    
    
   var currentShows: [TVShow] = []//[TVShow(name: "Walking Dead"), TVShow(name: "American Horror Story"), TVShow(name: "Trial and Error")]
    var upcomingShows: [TVShow] = []//[TVShow(name: "Game of Thrones"), TVShow(name: "Veep")]
    var completedShows: [TVShow] = []//[TVShow(name: "Sherlock"), TVShow(name: "Fargo"), TVShow(name: "Bodyguard")]
    
    var draggedFromTableView: UITableView?
    var draggedItemIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        Shows.guide().addShow(id: 1, to: .completed)
        Shows.guide().addShow(id: 2, to: .upcoming)
        Shows.guide().addShow(id: 3, to: .current)
        Shows.guide().addShow(id: 4, to: .completed)
        
        Shows.guide().moveShow(id: 4, from: .completed, to: .current)
        Shows.guide().removeShow(id: 4, from: .current)
        
        currentShowsTableView.delegate = self
        currentShowsTableView.dataSource = self
        currentShowsTableView.dropDelegate = self
        currentShowsTableView.dragDelegate = self
        currentShowsTableView.dragInteractionEnabled = true
        
        
        upcomingShowsTableView.delegate = self
        upcomingShowsTableView.dataSource = self
        upcomingShowsTableView.dropDelegate = self
        upcomingShowsTableView.dragDelegate = self
        upcomingShowsTableView.dragInteractionEnabled = true
        
        completedShowsTableView.delegate = self
        completedShowsTableView.dataSource = self
        completedShowsTableView.dropDelegate = self
        completedShowsTableView.dragDelegate = self
        completedShowsTableView.dragInteractionEnabled = true
        
        watchlistScrollView.delegate = self
        
        watchlistSegmentedControl.selectedSegmentIndex = 1
        watchlistScrollView.contentOffset = currentPoint
        
        TVAPIClient.fetchShowDetails(showID: 1399) { (show) in
            print(show)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currentShowsTableView {
            return currentShows.count
        } else if tableView == upcomingShowsTableView {
            return upcomingShows.count
        } else {
            return completedShows.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyShowTableViewCell!
        let show: TVShow!
        
        if tableView == currentShowsTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "currentShowCell") as! MyShowTableViewCell
            show = currentShows[indexPath.row]
        } else if tableView == upcomingShowsTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "upcomingShowCell") as! MyShowTableViewCell
            show = upcomingShows[indexPath.row]
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "completedShowCell") as! MyShowTableViewCell
            show = completedShows[indexPath.row]
        }
        
        cell.showNameLabel.text = show.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        var item: TVShow!
        if tableView == currentShowsTableView {
            item = currentShows[indexPath.row]
        } else if tableView == upcomingShowsTableView {
            item = upcomingShows[indexPath.row]
        } else {
            item = completedShows[indexPath.row]
        }
        
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        draggedFromTableView = tableView
        draggedItemIndexPath = indexPath
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        if session.localDragSession != nil {
            
            if tableView.hasActiveDrag {
                //If the drag originated in the same app and same tableview, then move it
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            } else {
                //If the drag originated in the same app but is going to a different tableview, then copy it
                return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
        } else {
            //If the drag originated from another app, forbid the drop
            return UITableViewDropProposal(operation: .forbidden)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        var item: TVShow!
        
        if tableView == currentShowsTableView {
            item = currentShows[sourceIndexPath.row]
            currentShows.remove(at: sourceIndexPath.row)
            currentShows.insert(item, at: destinationIndexPath.row)
        } else if tableView == upcomingShowsTableView {
            item = upcomingShows[sourceIndexPath.row]
            upcomingShows.remove(at: sourceIndexPath.row)
            upcomingShows.insert(item, at: destinationIndexPath.row)
        } else {
            item = completedShows[sourceIndexPath.row]
            completedShows.remove(at: sourceIndexPath.row)
            completedShows.insert(item, at: destinationIndexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            //If there is an index path, insert it there
            destinationIndexPath = indexPath
            
        } else {
            //Otherwise, just drop it at the end
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation {
        case .move:
            break
        case .copy:
            tableView.performBatchUpdates({
                var indexPaths = [IndexPath]()
                for (index, item) in coordinator.items.enumerated() {
                    //Destination index path for each item is calculated separately using the destinationIndexPath fetched from the coordinator
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                    if tableView == currentShowsTableView {
                        currentShows.insert(item.dragItem.localObject as! TVShow, at: indexPath.row)
                    } else if tableView == upcomingShowsTableView {
                        upcomingShows.insert(item.dragItem.localObject as! TVShow, at: indexPath.row)
                    } else {
                        completedShows.insert(item.dragItem.localObject as! TVShow, at: indexPath.row)
                    }
                    
                    indexPaths.append(indexPath)
                }
                tableView.insertRows(at: indexPaths, with: .automatic)
            })
            
            draggedFromTableView!.performBatchUpdates({
                var indexPaths = [draggedItemIndexPath!]
                if draggedFromTableView == currentShowsTableView {
                    currentShows.remove(at: draggedItemIndexPath!.row)
                } else if draggedFromTableView == upcomingShowsTableView {
                    upcomingShows.remove(at: draggedItemIndexPath!.row)
                } else {
                    completedShows.remove(at: draggedItemIndexPath!.row)
                }
                
                draggedFromTableView!.deleteRows(at: indexPaths, with: .automatic)
            })
            
        default:
            return
        }
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        
        switch watchlistSegmentedControl.selectedSegmentIndex {
        case 0:
            watchlistScrollView.setContentOffset(upcomingPoint, animated: true)
        case 1:
            watchlistScrollView.setContentOffset(currentPoint, animated: true)
        case 2:
            watchlistScrollView.setContentOffset(completedPoint, animated: true)
        default:
            break
        }
        
    }
    

    
    func updateSegmentedControl(point: CGPoint) {
        switch point {
        case upcomingPoint:
            watchlistSegmentedControl.selectedSegmentIndex = 0
        case currentPoint:
            watchlistSegmentedControl.selectedSegmentIndex = 1
        case completedPoint:
            watchlistSegmentedControl.selectedSegmentIndex = 2
            
        default:
            return
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateSegmentedControl(point: scrollView.contentOffset)
    }
    
}

