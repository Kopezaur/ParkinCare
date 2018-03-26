//
//  RDVSetViewModel.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/26/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -

/// Delegate to simulate reactive programming to change of RDV set
protocol RDVSetViewModelDelegate {
    // MARK: -
    
    /// called when set globally changes
    func dataSetChanged()
    /// called when a RDV is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func rdvDeleted(at indexPath: IndexPath)
    /// called when a RDV is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func rdvUpdated(at indexPath: IndexPath)
    /// called when a RDV is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func rdvAdded(at indexPath: IndexPath)
}

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class RDVSetViewModel : RDVTableViewModel{
    
    
    // MARK: -
    let modelset : RDVSet = RDVSet()
    
    /// NSFetchResultsController manage the set of RDVs that are persistents
    fileprivate lazy var rdvsFetched : NSFetchedResultsController<RDV> = {
        // prepare a request
        let request : NSFetchRequest<RDV> = RDV.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(RDV.dateTime),ascending:true),NSSortDescriptor(key:#keyPath(RDV.location),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        guard let fetchResultControllerDelegate = self.delegate as? NSFetchedResultsControllerDelegate else{
            fatalError("delegate of RDVSetViewModel should also be a NSFetchedResultsControllerDelegate")
        }
        fetchResultController.delegate = fetchResultControllerDelegate
        return fetchResultController
    }()
    
    var pdelegate : RDVSetViewModelDelegate?
    
    var delegate : RDVSetViewModelDelegate?{
        get{
            return self.pdelegate
        }
        set{
            self.pdelegate = newValue
            do{
                try self.rdvsFetched.performFetch()
            }
            catch let error as NSError{
                fatalError(error.description)
            }
        }
    }
    
    init() {
    }
    
    convenience init(delegate : RDVSetViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: RDVTableViewModel function
    
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int{
        guard let section = self.rdvsFetched.sections?[section] else { fatalError("Unexpected Section") }
        return section.numberOfObjects
    }
    
    /// return RDV at indexPath
    ///
    /// - Parameter indexPath: indexPath of RDV to be returned
    /// - Returns: RDV if there is one at this indexPath, else returns nil
    public func getRDV(at indexPath: IndexPath) -> RDV?{
        return self.rdvsFetched.object(at: indexPath)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    
    /// add a new RDV in set of RDVs
    ///
    /// - Parameter RDV: RDV to be added
    public func add(rdv: RDV){
        self.modelset.add(rdv: rdv)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: Convenience functions
    
}



