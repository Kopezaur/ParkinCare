//
//  EvaluationSetViewModel.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/29/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -

/// Delegate to simulate reactive programming to change of Evaluation set
protocol EvaluationSetViewModelDelegate {
    // MARK: -
    
    /// called when set globally changes
    func dataSetChanged()
    /// called when a Evaluation is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func evaluationDeleted(at indexPath: IndexPath)
    /// called when a Evaluation is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func evaluationUpdated(at indexPath: IndexPath)
    /// called when a Evaluation is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func evaluationAdded(at indexPath: IndexPath)
}

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class EvaluationSetViewModel : EvaluationTableViewModel{
    
     // MARK: -
     let modelset : EvaluationSet = EvaluationSet()
    
     /// NSFetchResultsController manage the set of Evaluations that are persistents
     fileprivate lazy var evaluationsFetched : NSFetchedResultsController<Evaluation> = {
        // prepare a request
        let request : NSFetchRequest<Evaluation> = Evaluation.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Evaluation.dateTime),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        guard let fetchResultControllerDelegate = self.delegate as? NSFetchedResultsControllerDelegate else{
            fatalError("delegate of EvaluationSetViewModel should also be a NSFetchedResultsControllerDelegate")
        }
        fetchResultController.delegate = fetchResultControllerDelegate
        return fetchResultController
     }()
    
     var pdelegate : EvaluationSetViewModelDelegate?
    
     var delegate : EvaluationSetViewModelDelegate?{
        get{
            return self.pdelegate
        }
        set{
            self.pdelegate = newValue
            do{
                try self.evaluationsFetched.performFetch()
            }
            catch let error as NSError{
                fatalError(error.description)
            }
        }
     }
    
     init() {
     }
    
     convenience init(delegate : EvaluationSetViewModelDelegate) {
         self.init()
         self.delegate = delegate
     }
    
     //-------------------------------------------------------------------------------------------------
     // MARK: EvaluationTableViewModel function
    
     /// numbers of rows for a given section
     ///
     /// - Parameter section: section we want the number of rows
     /// - Returns: number of rows for section
     func rowsCount(inSection section : Int) -> Int{
         guard let section = self.evaluationsFetched.sections?[section] else { fatalError("Unexpected Section") }
         return section.numberOfObjects
     }
    
     /// return Evaluation at indexPath
     ///
     /// - Parameter indexPath: indexPath of Evaluation to be returned
     /// - Returns: Evaluation if there is one at this indexPath, else returns nil
     public func getEvaluation(at indexPath: IndexPath) -> Evaluation?{
        return self.evaluationsFetched.object(at: indexPath)
     }
    
     //-------------------------------------------------------------------------------------------------
     // MARK: View Model functions
    
     /// add a new Evaluation in set of Evaluations
     ///
     /// - Parameter Evaluation: Evaluation to be added
     public func add(evaluation: Evaluation){
        self.modelset.add(evaluation: evaluation)
     }

    
     //-------------------------------------------------------------------------------------------------
     // MARK: Convenience functions
    
 }





