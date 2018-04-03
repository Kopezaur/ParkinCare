//
//  EvaluationFetchResultController.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EvaluationFetchResultController : NSObject, NSFetchedResultsControllerDelegate, EvaluationSetViewModelDelegate{
    
    let tableView  : UITableView
    let evaluationSet : EvaluationSetViewModel
    
    init(view : UITableView, model : EvaluationSetViewModel){
        self.tableView  = view
        self.evaluationSet = model
        super.init()
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - EvaluationSetViewModelDelegate
    func dataSetChanged(){
        self.tableView.reloadData()
    }
    func evaluationDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    func evaluationUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    func evaluationAdded(at indexPath: IndexPath){
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

