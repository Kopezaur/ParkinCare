//
//  PrescriptionSetViewModel.swift
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

/// Delegate to simulate reactive programming to change of Prescription set
protocol PrescriptionSetViewModelDelegate {
    // MARK: -
    
    /// called when set globally changes
    func dataSetChanged()
    /// called when a Prescription is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func prescriptionDeleted(at indexPath: IndexPath)
    /// called when a Prescription is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func prescriptionUpdated(at indexPath: IndexPath)
    /// called when a Prescription is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func prescriptionAdded(at indexPath: IndexPath)
}

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class PrescriptionSetViewModel : PrescriptionTableViewModel{
 
     // MARK: -
     let modelset : PrescriptionSet = PrescriptionSet()
    
     /// NSFetchResultsController manage the set of Prescriptions that are persistents
     fileprivate lazy var prescriptionsFetched : NSFetchedResultsController<Prescription> = {
         // prepare a request
         let request : NSFetchRequest<Prescription> = Prescription.fetchRequest()
         request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Prescription.dateTime),ascending:true)]
         let calendar = Calendar.current
         let dateMin : Date = calendar.date(byAdding: .minute, value: -15, to: Date())!
         request.predicate = NSPredicate(format: "dateTime > %@ && validated = 0", dateMin as NSDate)
         let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
         guard let fetchResultControllerDelegate = self.delegate as? NSFetchedResultsControllerDelegate else{
            fatalError("delegate of PrescriptionSetViewModel should also be a NSFetchedResultsControllerDelegate")
         }
         fetchResultController.delegate = fetchResultControllerDelegate
         return fetchResultController
     }()
    
     var pdelegate : PrescriptionSetViewModelDelegate?
    
     var delegate : PrescriptionSetViewModelDelegate?{
         get{
            return self.pdelegate
         }
         set{
            self.pdelegate = newValue
             do{
                try self.prescriptionsFetched.performFetch()
             }
             catch let error as NSError{
                fatalError(error.description)
             }
         }
     }
    
     init() {
     }
    
     convenience init(delegate : PrescriptionSetViewModelDelegate) {
         self.init()
         self.delegate = delegate
     }
    
     //-------------------------------------------------------------------------------------------------
     // MARK: PrescriptionTableViewModel function
    
     /// numbers of rows for a given section
     ///
     /// - Parameter section: section we want the number of rows
     /// - Returns: number of rows for section
     func rowsCount(inSection section : Int) -> Int{
         guard let section = self.prescriptionsFetched.sections?[section] else { fatalError("Unexpected Section") }
         return section.numberOfObjects
     }
    
     /// return Prescription at indexPath
     ///
     /// - Parameter indexPath: indexPath of Prescription to be returned
     /// - Returns: Prescription if there is one at this indexPath, else returns nil
     public func getPrescription(at indexPath: IndexPath) -> Prescription?{
        return self.prescriptionsFetched.object(at: indexPath)
     }
    
     //-------------------------------------------------------------------------------------------------
     // MARK: View Model functions
    
     /// add a new Prescription in set of Prescriptions
     ///
     /// - Parameter Prescription: Prescription to be added
     public func add(prescription: Prescription){
        self.modelset.add(prescription: prescription)
     }
 
 
 //-------------------------------------------------------------------------------------------------
 // MARK: Convenience functions
 
 }





