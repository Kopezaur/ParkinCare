//
//  ActivityFetchResultController.swift
//  ParkinCare
//
//  Created by julia on 31/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ActivityFetchResultController: NSObject, NSFetchedResultsControllerDelegate, ActivitySetViewModelDelegate {
    let tableView  : UITableView
    let activitySet : ActivitySetViewModel
    
    init(view : UITableView, model : ActivitySetViewModel){
        self.tableView  = view
        self.activitySet = model
        super.init()
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - ActivitySetViewModelDelegate
    func dataSetChanged(){
        self.tableView.reloadData()
    }
    func activityDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    func activityUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    func activityAdded(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath{
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}
