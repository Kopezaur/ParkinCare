//
//  File.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 24/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -

/// Delegate to simulate reactive programming to change of Professional set
protocol ProfessionalSetViewModelDelegate {
    // MARK: -
    
    /// called when set globally changes
    func dataSetChanged()
    /// called when a Professional is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func professionalDeleted(at indexPath: IndexPath)
    /// called when a Professional is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func professionalUpdated(at indexPath: IndexPath)
    /// called when a Professional is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func professionalAdded(at indexPath: IndexPath)
}

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class ProfessionalSetViewModel : ProfessionalTableViewModel{
    
    // MARK: -
    let modelset : ProfessionalSet = ProfessionalSet()
    
    /// NSFetchResultsController manage the set of Professionals that are persistents
    fileprivate lazy var professionalsFetched : NSFetchedResultsController<Professional> = {
        // prepare a request
        let request : NSFetchRequest<Professional> = Professional.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Professional.lastname.localizedUppercase),ascending:true),NSSortDescriptor(key:#keyPath(Professional.firstname.localizedUppercase),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        guard let fetchResultControllerDelegate = self.delegate as? NSFetchedResultsControllerDelegate else{
            fatalError("delegate of ProfessionalSetViewModel should also be a NSFetchedResultsControllerDelegate")
        }
        fetchResultController.delegate = fetchResultControllerDelegate
        return fetchResultController
    }()
    
    var pdelegate : ProfessionalSetViewModelDelegate?
    
    var delegate : ProfessionalSetViewModelDelegate?{
        get{
            return self.pdelegate
        }
        set{
            self.pdelegate = newValue
            do{
                try self.professionalsFetched.performFetch()
            }
            catch let error as NSError{
                fatalError(error.description)
            }
        }
    }
    
    init() {
    }
    
    convenience init(delegate : ProfessionalSetViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: ProfessionalTableViewModel function
    
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int{
        guard let section = self.professionalsFetched.sections?[section] else { fatalError("Unexpected Section") }
        return section.numberOfObjects
    }
    
    /// return Professional at indexPath
    ///
    /// - Parameter indexPath: indexPath of Professional to be returned
    /// - Returns: Professional if there is one at this indexPath, else returns nil
    public func getProfessional(at indexPath: IndexPath) -> Professional?{
        return self.professionalsFetched.object(at: indexPath)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    
    /// add a new Professional in set of Professionals
    ///
    /// - Parameter Professional: Professional to be added
    public func add(professional: Professional){
        self.modelset.add(professional: professional)
    }
    
    /// update birth date of Professional
    ///
    /// - Parameters:
    ///   - indexPath: (section,row) of Professional we want to update the birth date
    ///   - date: birth date
    /*public func updateBirthDate(atIndexPath indexPath: IndexPath, withDate date: Date){
        let Professional = self.professionalsFetched.object(at: indexPath)
        Professional.birthdate = date
        self.delegate?.ProfessionalUpdated(at: indexPath)
    }*/
    
    //-------------------------------------------------------------------------------------------------
    // MARK: Convenience functions
    
}
