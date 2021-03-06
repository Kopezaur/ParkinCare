//
//  ActivitySetViewModel.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -

/// Delegate to simulate reactive programming to change of Activity set
protocol ActivitySetViewModelDelegate {
    // MARK: -
    
    /// called when set globally changes
    func dataSetChanged()
    /// called when a Activity is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func activityDeleted(at indexPath: IndexPath)
    /// called when a Activity is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func activityUpdated(at indexPath: IndexPath)
    /// called when a Activity is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func activityAdded(at indexPath: IndexPath)
}

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class ActivitySetViewModel : ActivityTableViewModel{
    
    
    // MARK: -
    let modelset : ActivitySet = ActivitySet()
    
    /// NSFetchResultsController manage the set of Activitys that are persistents
    fileprivate lazy var activitysFetched : NSFetchedResultsController<Activity> = {
        // prepare a request
        let request : NSFetchRequest<Activity> = Activity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Activity.dateTime),ascending:true),NSSortDescriptor(key:#keyPath(Activity.title),ascending:true)]
        request.predicate = NSPredicate(format: "dateTime > %@ AND validated = 0", Date() as NSDate)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        guard let fetchResultControllerDelegate = self.delegate as? NSFetchedResultsControllerDelegate else{
            fatalError("delegate of ActivitySetViewModel should also be a NSFetchedResultsControllerDelegate")
        }
        fetchResultController.delegate = fetchResultControllerDelegate
        return fetchResultController
    }()
    
    var pdelegate : ActivitySetViewModelDelegate?
    
    var delegate : ActivitySetViewModelDelegate?{
        get{
            return self.pdelegate
        }
        set{
            self.pdelegate = newValue
            do{
                try self.activitysFetched.performFetch()
            }
            catch let error as NSError{
                fatalError(error.description)
            }
        }
    }
    
    init() {
    }
    
    convenience init(delegate : ActivitySetViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: ActivityTableViewModel function
    
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int{
        guard let section = self.activitysFetched.sections?[section] else { fatalError("Unexpected Section") }
        return section.numberOfObjects
    }
    
    /// return Activity at indexPath
    ///
    /// - Parameter indexPath: indexPath of Activity to be returned
    /// - Returns: Activity if there is one at this indexPath, else returns nil
    public func getActivity(at indexPath: IndexPath) -> Activity?{
        return self.activitysFetched.object(at: indexPath)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    
    /// add a new Activity in set of Activities
    ///
    /// - Parameter Activity: Activity to be added
    public func add(activity: Activity){
        self.modelset.add(activity: activity)
    }
    
    /// remove an Activity in set of Activities
    ///
    /// - Parameter Activity: Activity to be remove
    public func remove(activity: Activity){
        self.modelset.remove(activity: activity)
    }
    
    public func remove(indexPath: IndexPath){
        self.remove(activity: self.getActivity(at: indexPath)!)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: Convenience functions
    
}



