//
//  PersonFetchResultController.swift
//  TP08-CoreData-MVVM
//
//  Created by Fiorio Christophe on 17/03/2018.
//  Copyright © 2018 Christophe Fiorio. All rights reserved.
//

import UIKit
import CoreData

class ProfessionalFetchResultController: NSObject, NSFetchedResultsControllerDelegate, ProfessionalSetViewModelDelegate{
    
    
    let tableView  : UITableView
    let personsSet : ProfessionalSetViewModel
    
    init(view : UITableView, model : ProfessionalSetViewModel){
        self.tableView  = view
        self.personsSet = model
        super.init()
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - PersonSetViewModelDelegate
    func dataSetChanged(){
        self.tableView.reloadData()
    }
    func professionalDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    func professionalUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    func professionalAdded(at indexPath: IndexPath){
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

